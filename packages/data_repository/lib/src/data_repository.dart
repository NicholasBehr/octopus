import 'package:data_api/data_api.dart';

/// {@template data_repository}
/// A repository that handles storage & database related requests.
/// {@endtemplate}
class DataRepository {
  /// {@macro data_repository}
  const DataRepository({
    required DataApi dataApi,
  }) : _dataApi = dataApi;

  final DataApi _dataApi;

  /// Provides a live [Stream] of [UserData] from the database.
  ///
  /// Remember to cancel any StreamSubscription!
  Stream<UserData> getUserDataStream(String uid) =>
      _dataApi.getUserDataStream(uid);

  /// (Over-)writes the provided [UserData] to the database.
  Future<void> setUserData(UserData userData) => _dataApi.setUserData(userData);
}
