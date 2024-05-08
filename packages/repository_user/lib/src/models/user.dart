import 'package:api_auth/api_auth.dart' as auth;
import 'package:api_data/api_data.dart' as data;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class User extends Equatable {
  User({
    required auth.AuthUser authUser,
    required data.DataUser dataUser,
  })  : _authUser = authUser,
        _dataUser = dataUser,
        assert(authUser.id == dataUser.id, 'user id missmatch!');

  final auth.AuthUser _authUser;
  final data.DataUser _dataUser;

  /// The unique identifier of the 'user'.
  ///
  /// Cannot be empty
  String get id => _authUser.id;

  /// The name associated with the 'user'.
  ///
  /// Note that the displayName may be empty.
  String get name => _authUser.name;

  /// The email associated with the 'user'.
  ///
  /// Note that the email may be empty.
  String get email => _authUser.email;

  /// Is the email of the user verified?
  ///
  /// Defaults to 'false'.
  bool get emailVerified => _authUser.emailVerified;

  /// Has the onboarding flow been completed/skipped by this user?
  ///
  /// Defaults to false.
  bool get hasCompletedOnboarding => _dataUser.hasCompletedOnboarding;

  /// List of account id's the user created / owns
  ///
  /// Defaults to emty list.
  List<String> get ownAccounts => _dataUser.ownAccounts;

  @override
  List<Object> get props => [_authUser, _dataUser];
}
