import 'package:api_data/api_data.dart';

/// {@template api_data}
/// The interface and models for an API providing access to database storage.
/// {@endtemplate}
abstract class ApiData {
  /// {@macro api_data}
  const ApiData();

  /// Provides a realtime [Stream] of [DataUser] from the database.
  /// Provides default [DataUser] opbject if there is no database entry.
  ///
  /// Remember to cancel subscription to fee resources!
  Stream<DataUser> getDataUserStream(String id);

  /// (Over-)writes the provided [DataUser] into the database.
  Future<void> setUserData(DataUser userData);
}
