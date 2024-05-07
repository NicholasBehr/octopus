import 'package:api_data/api_data.dart';

/// {@template api_data}
/// The interface and models for an API providing access to database storage.
/// {@endtemplate}
abstract class ApiData {
  /// {@macro api_data}
  const ApiData();

  /// Provides a realtime [Stream] of [User] from the database.
  /// Provides default [User] opbject if there is no database entry.
  ///
  /// Remember to cancel subscription to fee resources!
  Stream<User> getUserStream(String id);

  /// (Over-)writes the provided [User] into the database.
  Future<void> setUserData(User userData);
}
