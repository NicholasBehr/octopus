import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserData extends Equatable {
  const UserData({
    required this.uid,
    bool? hasCompletedOnboarding,
  })  : hasCompletedOnboarding = hasCompletedOnboarding ?? false,
        assert(uid != '', 'uid cannot be empty');

  /// Create [UserData] model from firebase [DocumentSnapshot]
  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    // function format defined by firestore
    // ignore: avoid_unused_constructor_parameters
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      uid: snapshot.reference.id,
      hasCompletedOnboarding: data?['hasCompletedOnboarding'] as bool?,
    );
  }

  /// The unique identifier of the user
  ///
  /// Cannot be empty
  final String uid;

  /// Has the onboarding flow been completed/skipped by this user?
  final bool hasCompletedOnboarding;

  /// Create firebase json from [UserData] model
  Map<String, dynamic> toFirestore() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding,
    };
  }

  @override
  List<Object> get props => [uid, hasCompletedOnboarding];
}
