// ignore_for_file: prefer_const_constructors

import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthApi extends Mock implements AuthApi {}

void main() {
  group('AuthRepository', () {
    late AuthApi api;

    final user = User(uid: '1');

    setUp(() {
      api = MockAuthApi();
      when(() => api.getAuthUpdates())
          .thenAnswer((_) => Stream.value(AuthUpdate.right(user)));
      when(
        () => api.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => api.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => api.signOut(),
      ).thenAnswer((_) async => {});
    });

    AuthRepository createSubject() => AuthRepository(authApi: api);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });
  });
}
