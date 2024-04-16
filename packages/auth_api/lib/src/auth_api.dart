import 'package:auth_api/auth_api.dart';
import 'package:fpdart/fpdart.dart';

/// {@template auth_api}
/// The interface and models for an API providing user authentication.
/// {@endtemplate}
abstract class AuthApi {
  /// {@macro auth_api}
  const AuthApi();

  /// Provides a [Stream] of user auth updates
  ///
  /// Returns Either [AuthException] or authenticated [User],
  /// might be [None]
  Stream<Either<AuthException, Option<User>>> getUser();

  /// Tries to create a new user account
  /// with the given email address and password.
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Attempts to sign in a user
  /// with the given email address and password.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs out the current user.
  Future<void> signOut();
}

/// Error thrown when a [AuthApi] transaction fails.
class AuthException implements Exception {}
