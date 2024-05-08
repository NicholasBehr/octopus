import 'package:api_auth/api_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

/// {@template api_auth_firebase}
/// A Flutter implementation of the AuthApi that uses google firebase.
/// {@endtemplate}
class ApiAuthFirebase implements ApiAuth {
  ApiAuthFirebase({firebase.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase.FirebaseAuth.instance;

  final firebase.FirebaseAuth _firebaseAuth;

  @override
  Stream<AuthUser?> getAuthUserStream() => _firebaseAuth
      .authStateChanges()
      .map((firebaseUser) => firebaseUser?.toUser);

  /// Tries to create a new 'user'
  /// with the given email address and password.
  ///
  /// Throws an [UserCreationException] if an exception occurs.
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
    } catch (_) {
      throw UserCreationException();
    }
  }

  /// Attempts to sign into an 'user' account
  /// with the given email address and password.
  ///
  /// Throws an [UserSignInException] if an exception occurs.
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
    } catch (_) {
      throw UserSignInException();
    }
  }

  /// Signs out the 'user'.
  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on firebase.FirebaseAuthException {
      throw UnimplementedError();
    }
  }
}

extension on firebase.User {
  /// Maps a [firebase.User] into a [AuthUser].
  AuthUser get toUser {
    return AuthUser(
      id: uid,
      name: displayName,
      email: email,
      emailVerified: emailVerified,
    );
  }
}
