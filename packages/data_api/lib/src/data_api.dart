import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_api/data_api.dart';

/// {@template data_api}
/// The implementation for an API providing access to database storage.
/// {@endtemplate}
class DataApi {
  /// {@macro data_api}
  DataApi({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  /// Provides a live singe subscriber [Stream] of [UserData] from the database.
  /// Provides default [UserData] opbject if there is no database entry.
  ///
  /// Remember to cancel any StreamSubscription!
  Stream<UserData> getUserDataStream(String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, _) => userData.toFirestore(),
        )
        .snapshots()
        .map((docSnapshot) {
      if (docSnapshot.exists) {
        return docSnapshot.data()!;
      } else {
        return UserData(uid: uid);
      }
    });
  }

  /// (Over-)writes the provided [UserData] into the database.
  Future<void> setUserData(UserData userData) {
    return _firebaseFirestore
        .collection('users')
        .doc(userData.uid)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, _) => userData.toFirestore(),
        )
        .set(userData);
  }

  Future<List<TransactionData>> getTransactionPage(
    String account,
    int page,
    int limit,
  ) async {
    final querySnapshot = await _firebaseFirestore
        .collection('accounts')
        .doc(account)
        .collection('transactions')
        .orderBy('transactionDate')
        .startAt([page * limit])
        .limit(limit)
        .withConverter(
          fromFirestore: TransactionData.fromFirestore,
          toFirestore: (TransactionData transactionData, _) =>
              transactionData.toFirestore(),
        )
        .get();

    // Convert the QuerySnapshot to a list of TransactionData
    final transactions = querySnapshot.docs.map((doc) => doc.data()).toList();

    return transactions;
  }

  /// (Over-)writes the provided [TransactionData] into the database.
  Future<void> setTransactionData(TransactionData transactionData) {
    return _firebaseFirestore
        .collection('users')
        .doc(transactionData.uid)
        .withConverter(
          fromFirestore: TransactionData.fromFirestore,
          toFirestore: (TransactionData transactionData, _) =>
              transactionData.toFirestore(),
        )
        .set(transactionData);
  }
}
