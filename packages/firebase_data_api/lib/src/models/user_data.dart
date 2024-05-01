import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_api/data_api.dart' as data_api;

class FirestoreUserData extends data_api.UserData {
  const FirestoreUserData({
    required super.uid,
    super.hasCompletedOnboarding,
  });

  factory FirestoreUserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return FirestoreUserData(
      uid: snapshot.reference.id,
      hasCompletedOnboarding: data?['hasCompletedOnboarding'] as bool?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding,
    };
  }
}
