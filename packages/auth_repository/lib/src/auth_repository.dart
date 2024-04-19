import 'package:auth_api/auth_api.dart';

/// {@template auth_repository}
/// A repository that handles authentication related requests.
/// {@endtemplate}
class AuthRepository {
  /// {@macro auth_repository}
  const AuthRepository({
    required AuthApi authApi,
  }) : _authApi = authApi;

  final AuthApi _authApi;

  /// Provides a [Stream] of live [AuthUpdate]
  Stream<AuthUpdate> getAuthUpdates() => _authApi.getAuthUpdates();

  /// Tries to create a new user account
  /// with the given email address and password.
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _authApi.createUserWithEmailAndPassword(email: email, password: password);

  /// Attempts to sign in a user
  /// with the given email address and password.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _authApi.signInWithEmailAndPassword(email: email, password: password);

  /// Signs out the current user.
  Future<void> signOut() => _authApi.signOut();
}
