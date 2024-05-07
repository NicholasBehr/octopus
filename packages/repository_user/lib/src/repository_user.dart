import 'dart:async';
import 'package:api_auth/api_auth.dart' as auth;
import 'package:api_data/api_data.dart' as data;
import 'package:repository_user/repository_user.dart';
import 'package:repository_user/src/models/user.dart';

/// {@template repository_user}
/// A repository that handles user lifecycle related requests.
/// {@endtemplate}
class RepositoryUser {
  /// {@macro repository_user}
  const RepositoryUser({
    required this.apiAuth,
    required this.apiData,
  });

  final auth.ApiAuth apiAuth;
  final data.ApiData apiData;

  Stream<User?> getUserDataStream() {
    late StreamController<User?> controller;

    StreamSubscription<auth.User?>? authStream;
    StreamSubscription<data.User>? dataStream;
    User? user;

    void onData(data.User dataUser) {
      controller.add(user?.copyWith(dataUser: dataUser));
    }

    void onAuth(auth.User? authUser) {
      if (authUser == null) {
        // signed out
        user = null;
        dataStream?.cancel();
      } else {
        // signed in
        user = User(authUser: authUser);
        dataStream = apiData.getUserStream(authUser.id).listen(onData);
      }
      controller.add(user);
    }

    void onStart() {
      authStream = apiAuth.getUserStream().listen(onAuth);
    }

    void onStop() {
      authStream?.cancel();
      dataStream?.cancel();
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
      apiAuth.createUserWithEmailAndPassword(email: email, password: password);

  /// Attempts to sign into an 'user' account
  /// with the given email address and password.
  ///
  /// Throws an [UserSignInException] if an exception occurs.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      apiAuth.signInWithEmailAndPassword(email: email, password: password);

  /// Signs out the 'user'.
  Future<void> signOut() => apiAuth.signOut();
}
