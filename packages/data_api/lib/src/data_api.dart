import 'package:data_api/data_api.dart';

/// {@template data_api}
/// The interface and models for an API providing access to database storage.
/// {@endtemplate}
abstract class DataApi {
  /// {@macro data_api}
  const DataApi();

  /// Provides a live [Stream] of [UserData] from the database.
  ///
  /// Remember to cancel any StreamSubscription!
  Stream<UserData> getUserDataStream(String uid);

  /// (Over-)writes the provided [UserData] to the database.
  Future<void> setUserData(UserData userData);
}
