// ignore_for_file: prefer_const_constructors
import 'package:auth_api/auth_api.dart';
import 'package:test/test.dart';

class TestAuthApi extends AuthApi {
  TestAuthApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('AuthApi', () {
    test('can be instantiated', () {
      expect(TestAuthApi.new, isNotNull);
    });
  });
}
