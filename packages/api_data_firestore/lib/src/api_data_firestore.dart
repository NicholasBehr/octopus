import 'package:api_data/api_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A Flutter implementation of the DataAPI that uses google cloud firestore.
class ApiDataFirestore implements ApiData {
  ApiDataFirestore({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  /// -- UserData --

  /// Provides a realtime [Stream] of [DataUser] from the database.
  /// Provides default [DataUser] opbject if there is no database entry.
  ///
  /// Remember to cancel subscription to fee resources!
  @override
  Stream<DataUser> getDataUserStream(String id) {
    return _firebaseFirestore.collection('users').doc(id).snapshots().map(
          (docSnapshot) => docSnapshot.exists
              ? DataUser.fromJson(id, docSnapshot.data()!)
              : DataUser(id: id),
        );
  }

  /// (Over-)writes the provided [DataUser] into the database.
  @override
  Future<void> setUserData(DataUser user) {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toJson());
  }
}
