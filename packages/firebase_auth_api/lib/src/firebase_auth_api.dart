import 'package:auth_api/auth_api.dart' as auth_api;
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/rxdart.dart';

/// {@template firebase_auth_api}
/// A Flutter implementation of the AuthApi that uses firebase.
/// {@endtemplate}
class FirebaseAuthApi extends auth_api.AuthApi {
  /// {@macro firebase_auth_api}
  FirebaseAuthApi({firebase.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase.FirebaseAuth.instance {
    _init();
  }

  final firebase.FirebaseAuth _firebaseAuth;

  final _authStreamController =
      BehaviorSubject<Either<auth_api.AuthFailure, auth_api.User?>>.seeded(
    Either<auth_api.AuthFailure, auth_api.User?>.of(null),
  );

  void _init() {
    _firebaseAuth.authStateChanges().forEach(
          (firebaseUser) => _authStreamController.add(
            Either<auth_api.AuthFailure, auth_api.User?>.right(
              firebaseUser != null
                  ? auth_api.User(
                      uid: firebaseUser.uid,
                      displayName: firebaseUser.displayName,
                      email: firebaseUser.email,
                    )
                  : null,
            ),
          ),
        );
  }

  @override
  Stream<Either<auth_api.AuthFailure, auth_api.User?>> getUser() =>
      _authStreamController.asBroadcastStream();

  @override
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
      final auth_api.AuthFailure authFailure;
      switch (e.code) {
        case 'email-already-in-use':
          authFailure = auth_api.AuthFailure.emailAlreadyInUse;
        case 'invalid-email':
          authFailure = auth_api.AuthFailure.invalidEmail;
        case 'weak-password':
          authFailure = auth_api.AuthFailure.weakPassword;
        default:
          throw UnimplementedError();
      }
      _authStreamController.add(
        Either<auth_api.AuthFailure, auth_api.User?>.left(authFailure),
      );
    }
  }

  @override
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
      final auth_api.AuthFailure authFailure;
      switch (e.code) {
        case 'invalid-email':
          authFailure = auth_api.AuthFailure.invalidEmail;
        case 'user-disabled':
          authFailure = auth_api.AuthFailure.userDisabled;
        case 'user-not-found':
          authFailure = auth_api.AuthFailure.userNotFound;
        case 'wrong-password':
          authFailure = auth_api.AuthFailure.wrongPassword;
        default:
          throw UnimplementedError();
      }
      _authStreamController.add(
        Either<auth_api.AuthFailure, auth_api.User?>.left(authFailure),
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on firebase.FirebaseAuthException {
      throw UnimplementedError();
    }
  }
}
