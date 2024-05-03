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

  /// (Over-)writes the provided [UserData] into the database.
  Future<void> setUserData(UserData userData) => _dataApi.setUserData(userData);

  Future<List<TransactionData>> getTransactionPage(
    String account,
    int page,
    int limit,
  ) =>
      _dataApi.getTransactionPage(account, page, limit);
}
