// ignore_for_file: prefer_const_constructors

import 'package:auth_api/auth_api.dart' as auth_api;
import 'package:firebase_auth_api/firebase_auth_api.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  group('FirebaseAuthApi', () {
    final user = MockUser(
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );

    final firebaseAuth = MockFirebaseAuth(mockUser: user);

    FirebaseAuthApi createSubject() {
      return FirebaseAuthApi(
        firebaseAuth: firebaseAuth,
      );
    }

    final userNull = Either<auth_api.AuthFailure, auth_api.User?>.right(null);
    final userBob =
        Either<auth_api.AuthFailure, auth_api.User?>.right(auth_api.User(
      uid: 'someuid',
    ));

    test('constructor works properly', () {
      expect(
        createSubject,
        returnsNormally,
      );
    });

    test('get User returns null user while', () {
      final subject = createSubject();
      expect(
        subject.getUser(),
        emits(userNull),
      );
    });

    test('sign in existing user', () async {
      final subject = createSubject();

      await subject.signInWithEmailAndPassword(
        email: 'bob@somedomain.com',
        password: 'password123',
      );

      expect(
        subject.getUser(),
        emits(userBob),
      );
    });
  });
}
