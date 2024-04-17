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
  /// Returns Either [AuthFailure] or authenticated [User]
  Stream<Either<AuthFailure, User?>> getUser();

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
