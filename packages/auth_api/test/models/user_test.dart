// ignore_for_file: avoid_redundant_argument_values
import 'package:auth_api/auth_api.dart';
import 'package:test/test.dart';

void main() {
  group('AuthApi', () {
    User createSubject({
      String uid = '1',
      String? displayName = 'Mark',
      String? email = 'mark@mail.ch',
    }) {
      return User(
        uid: uid,
        displayName: displayName,
        email: email,
      );
    }

    /// Constructor
    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      test('throws AssertionError when uid is empty', () {
        expect(
          () => createSubject(uid: ''),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals([
          '1', // uid
          'Mark', // displayname
          'mark@mail.ch', // mail
        ]),
      );
    });

    test('missing fields are filled', () {
      expect(
        createSubject(displayName: null, email: null).props,
        equals([
          '1', // uid
          '', // displayname
          '', // mail
        ]),
      );
    });
  });
}
