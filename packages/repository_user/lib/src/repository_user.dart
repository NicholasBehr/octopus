import 'dart:async';
import 'package:api_auth/api_auth.dart';
import 'package:api_data/api_data.dart';
import 'package:repository_user/repository_user.dart';
import 'package:repository_user/src/models/user.dart';

/// {@template repository_user}
/// A repository that handles user lifecycle related requests.
/// {@endtemplate}
class RepositoryUser {
  /// {@macro repository_user}
  const RepositoryUser({
    required ApiAuth apiAuth,
    required ApiData apiData,
  })  : _apiAuth = apiAuth,
        _apiData = apiData;

  final ApiAuth _apiAuth;
  final ApiData _apiData;

  Stream<User?> getUserStream() {
    late StreamController<User?> controller;

    StreamSubscription<AuthUser?>? authStream;
    StreamSubscription<DataUser>? dataStream;

    void onData(AuthUser authUser, DataUser dataUser) {
      // id match guard clause
      if (authUser.id != dataUser.id) return;

      // sign in (part 2 of 2)
      // notify subscribers about sign in
      controller.add(User(authUser: authUser, dataUser: dataUser));
    }

    Future<void> onAuth(AuthUser? authUser) async {
      // sign in (part 1 of 2)
      if (authUser != null) {
        dataStream = _apiData
            .getDataUserStream(authUser.id)
            .listen((dataUser) => onData(authUser, dataUser));
      }
      // sign out
      else {
        // clean up old user, wait for all onData to finish
        await dataStream?.cancel();
        // notify subscribers about sign out
        controller.add(null);
      }
    }

    void onStart() {
      authStream = _apiAuth.getAuthUserStream().listen(onAuth);
    }

    Future<void> onStop() async {
      await authStream?.cancel();
      await dataStream?.cancel();
    }

    controller = StreamController<User?>(
      onListen: onStart,
      onPause: onStop,
      onResume: onStart,
      onCancel: onStop,
    );

    return controller.stream.distinct();
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _apiAuth.createUserWithEmailAndPassword(email: email, password: password);

  /// Attempts to sign into an 'user' account
  /// with the given email address and password.
  ///
  /// Throws an [UserSignInException] if an exception occurs.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _apiAuth.signInWithEmailAndPassword(email: email, password: password);

  /// Signs out the 'user'.
  Future<void> signOut() => _apiAuth.signOut();
}
