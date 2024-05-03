import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserData extends Equatable {
  const UserData({
    required this.uid,
    this.hasCompletedOnboarding,
    this.ownAccounts,
  }) : assert(uid != '', 'uid cannot be empty');

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
      ownAccounts: data?['ownAccounts'] is Iterable
          ? List.from(data?['ownAccounts'] as Iterable<dynamic>)
          : null,
    );
  }

  /// The unique identifier of the user
  ///
  /// Cannot be empty
  final String uid;

  /// Has the onboarding flow been completed/skipped by this user?
  final bool? hasCompletedOnboarding;

  /// List of account uid's the user created / owns
  final List<String>? ownAccounts;

  /// Returns a copy of this [UserData] with the given values updated.
  UserData copyWith({
    String? uid,
    bool? hasCompletedOnboarding,
    List<String>? ownAccounts,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      ownAccounts: ownAccounts ?? this.ownAccounts,
    );
  }

  /// Create firebase json from [UserData] model
  Map<String, dynamic> toFirestore() {
    return {
      if (hasCompletedOnboarding != null)
        'hasCompletedOnboarding': hasCompletedOnboarding,
      if (ownAccounts != null) 'ownAccounts': ownAccounts,
    };
  }

  @override
  List<Object?> get props => [uid, hasCompletedOnboarding, ownAccounts];
}
