// ignore_for_file: prefer_const_constructors

import 'package:auth_api/auth_api.dart' as auth_api;
import 'package:firebase_auth_api/firebase_auth_api.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseAuthApi', () {
    final userFirebaseAlice = MockUser(
      uid: 'someuid',
      email: 'alice@somedomain.com',
      displayName: 'Alice',
    );

    final userAlice = auth_api.User(
      uid: 'someuid',
      email: 'alice@somedomain.com',
      displayName: 'Alice',
    );

    final userBob = auth_api.User(
      uid: 'otheruid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );

    final firebaseAuth = MockFirebaseAuth(mockUser: userFirebaseAlice);

    FirebaseAuthApi createSubject() {
      return FirebaseAuthApi(
        firebaseAuth: firebaseAuth,
      );
    }

    test('constructor works properly', () {
      expect(
        createSubject,
        returnsNormally,
      );
    });

    test('getAuthUpdates returns null at idle', () {
      final subject = createSubject();
      expect(
        subject.getAuthUpdates(),
        emits(auth_api.AuthUpdate.of(null)),
      );
    });

    test('create new user', () async {
      final subject = createSubject();

      await subject.createUserWithEmailAndPassword(
        email: 'bob@somedomain.com',
        password: 'password123',
      );

      await Future.delayed(Duration(seconds: 1));

      expect(
        subject.getAuthUpdates(),
        emits(userBob),
      );
    });

    test('sign in existing user', () async {
      final subject = createSubject();

      await subject.signInWithEmailAndPassword(
        email: 'bob@somedomain.com',
        password: 'password123',
      );

      await Future.delayed(Duration(seconds: 1));

      expect(
        subject.getAuthUpdates(),
        emits(userBob),
      );
    });

    test('sign out', () async {
      final subject = createSubject();

      await subject.signInWithEmailAndPassword(
        email: 'alice@somedomain.com',
        password: 'password123',
      );
      await subject.signOut();

      await Future.delayed(Duration(seconds: 1));

      expect(
        subject.getAuthUpdates(),
        emits(auth_api.AuthUpdate.of(null)),
      );
    });
  });
}
