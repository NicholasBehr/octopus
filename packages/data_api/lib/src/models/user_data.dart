import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserData extends Equatable {
  const UserData({
    required this.uid,
    bool? hasCompletedOnboarding,
  })  : hasCompletedOnboarding = hasCompletedOnboarding ?? false,
        assert(uid != '', 'uid cannot be empty');

  /// The unique identifier of the user
  ///
  /// Cannot be empty
  final String uid;

  /// Has the onboarding flow been completed/skipped by this user?
  final bool hasCompletedOnboarding;

  @override
  List<Object> get props => [uid, hasCompletedOnboarding];
}
