import 'package:api_data/api_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A Flutter implementation of the DataAPI that uses google cloud firestore.
class ApiDataFirestore implements ApiData {
  ApiDataFirestore({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  /// -- UserData --

  /// Provides a realtime [Stream] of [User] from the database.
  /// Provides default [User] opbject if there is no database entry.
  ///
  /// Remember to cancel subscription to fee resources!
  @override
  Stream<User> getUserStream(String id) {
    return _firebaseFirestore.collection('users').doc(id).snapshots().map(
          (docSnapshot) => docSnapshot.exists
              ? User.fromJson(id, docSnapshot.data()!)
              : User(id: id),
        );
  }

  /// (Over-)writes the provided [User] into the database.
  @override
  Future<void> setUserData(User user) {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toJson());
  }
}
