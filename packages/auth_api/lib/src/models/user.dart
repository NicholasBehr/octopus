import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:meta/meta.dart';

@immutable
class User extends Equatable {
  const User({
    required this.uid,
    String? displayName,
    String? email,
    bool? emailVerified,
  })  : displayName = displayName ?? '',
        email = email ?? '',
        emailVerified = emailVerified ?? false,
        assert(uid != '', 'uid cannot be empty');

  /// Create [User] model from firebase [firebase.User]
  factory User.fromFirebase(firebase.User firebaseUser) {
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      emailVerified: firebaseUser.emailVerified,
    );
  }

  /// The unique identifier of the user
  ///
  /// Cannot be empty
  final String uid;

  /// The display name associated with the user
  final String displayName;

  /// The email associated with the user
  final String email;

  /// Is the email of the user verified?
  final bool emailVerified;

  /// Returns a copy of this `user` with the given values updated.
  User copyWith({
    String? uid,
    String? displayName,
    String? email,
    bool? emailVerified,
  }) {
    return User(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  List<Object> get props => [uid, displayName, email, emailVerified];
}
