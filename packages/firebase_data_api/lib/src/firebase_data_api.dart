import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_api/data_api.dart';
import 'package:firebase_data_api/src/models/user_data.dart';

/// {@template firebase_data_api}
/// A Flutter implementation of the DataApi that uses firebase cloud firestore.
/// {@endtemplate}
class FirebaseDataApi implements DataApi {
  /// {@macro firebase_data_api}
  FirebaseDataApi({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  @override
  Stream<UserData> getUserDataStream(String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((docSnapshot) {
      if (docSnapshot.exists) {
        return FirestoreUserData.fromFirestore(docSnapshot);
      } else {
        return FirestoreUserData(uid: uid);
      }
    });
  }

  @override
  Future<void> setUserData(UserData userData) {
    return _firebaseFirestore
        .collection('users')
        .doc(userData.uid)
        .set((userData as FirestoreUserData).toFirestore());
  }
}
