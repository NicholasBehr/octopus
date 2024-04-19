import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class User extends Equatable {
  User({
    required this.uid,
    String? displayName,
    String? email,
  })  : displayName = displayName ?? '',
        email = email ?? '',
        assert(uid.isNotEmpty, 'uid cannot be empty');

  /// The unique identifier of the user
  ///
  /// Cannot be empty
  final String uid;

  /// The display name associated with the user
  final String displayName;

  /// The email associated with the user
  final String email;

  /// Returns a copy of this `user` with the given values updated.
  User copyWith({
    String? uid,
    String? displayName,
    String? email,
    bool? verified,
  }) {
    return User(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [uid, displayName, email];
}
