import 'package:api_auth/api_auth.dart';

/// The interface and models for an API providing access to authentication.
abstract class ApiAuth {
  const ApiAuth();

  /// Provides a live [Stream] of [User] updates from online user account.
  ///
  /// Note that the [User] may be null if not signed in.
  Stream<User?> getUserStream();

  /// Tries to create a new 'user'
  /// with the given email address and password.
  ///
  /// Throws an [UserCreationException] if an exception occurs.
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Attempts to sign into an 'user' account
  /// with the given email address and password.
  ///
  /// Throws an [UserSignInException] if an exception occurs.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs out the 'user'.
  Future<void> signOut();
}

/// Thrown during the user account creation process if a failure occurs.
class UserCreationException implements Exception {}

/// Thrown during the user account sign in process if a failure occurs.
class UserSignInException implements Exception {}
