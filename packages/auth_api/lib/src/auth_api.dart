import 'package:auth_api/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/subjects.dart';

/// Used to convey changes to auth state,
/// [UserAuth] can be null if signed out
typedef AuthUpdate = Either<AuthFailure, UserAuth?>;

/// {@template auth_api}
/// The interface and models for an API providing user authentication.
/// {@endtemplate}
class AuthApi {
  /// {@macro auth_api}
  AuthApi({firebase.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase.FirebaseAuth.instance {
    _init();
  }

  final firebase.FirebaseAuth _firebaseAuth;

  // Broadcast StreamController
  final _authStreamController = BehaviorSubject<AuthUpdate>.seeded(
    AuthUpdate.of(null),
  );

  void _init() {
    _authStreamController.addStream(
      _firebaseAuth.authStateChanges().map(
            (firebaseUser) => AuthUpdate.right(
              firebaseUser != null ? UserAuth.fromFirebase(firebaseUser) : null,
            ),
          ),
    );
  }

  /// Provides a live singe subscriber [Stream] of [AuthUpdate].
  Stream<AuthUpdate> getAuthUpdates() {
    return _firebaseAuth.authStateChanges().map(
          (firebaseUser) => AuthUpdate.right(
            firebaseUser != null ? UserAuth.fromFirebase(firebaseUser) : null,
          ),
        );
  }

  /// Tries to create a new user account
  /// with the given email address and password.
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase.FirebaseAuthException catch (e) {
      final AuthFailure authFailure;
      switch (e.code) {
        case 'email-already-in-use':
          authFailure = AuthFailure.emailAlreadyInUse;
        case 'invalid-email':
          authFailure = AuthFailure.invalidEmail;
        case 'weak-password':
          authFailure = AuthFailure.weakPassword;
        default:
          throw UnimplementedError();
      }
      _authStreamController.add(
        AuthUpdate.left(authFailure),
      );
    }
  }

  /// Attempts to sign in a user
  /// with the given email address and password.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase.FirebaseAuthException catch (e) {
      final AuthFailure authFailure;
      switch (e.code) {
        case 'invalid-email':
          authFailure = AuthFailure.invalidEmail;
        case 'user-disabled':
          authFailure = AuthFailure.userDisabled;
        case 'user-not-found':
          authFailure = AuthFailure.userNotFound;
        case 'wrong-password':
          authFailure = AuthFailure.wrongPassword;
        default:
          throw UnimplementedError();
      }
      _authStreamController.add(
        AuthUpdate.left(authFailure),
      );
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on firebase.FirebaseAuthException {
      throw UnimplementedError();
    }
  }
}

/// Description of what [AuthApi] transaction failed.
enum AuthFailure {
  /// there already exists an account with the given email address
  emailAlreadyInUse,

  /// the email address is not valid
  invalidEmail,

  /// the password is not strong enough
  weakPassword,

  /// the user corresponding to the given email has been disabled
  userDisabled,

  /// there is no user corresponding to the given email
  userNotFound,

  /// the password is invalid for the given email,
  /// or the account corresponding to the email does not have a password set
  wrongPassword,
}
