// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth_api/firebase_auth_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseAuthApi', () {
    test('can be instantiated', () {
      expect(FirebaseAuthApi(), isNotNull);
    });
  });
}
