import 'package:api_auth/api_auth.dart' as auth;
import 'package:api_data/api_data.dart' as data;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class User extends Equatable {
  User({
    required this.authUser,
    data.User? dataUser,
  })  : id = authUser.id,
        dataUser = dataUser ?? data.User(id: authUser.id),
        assert(dataUser == null || authUser.id == dataUser.id, 'id missmatch');

  final String id;

  final auth.User authUser;

  final data.User dataUser;

  /// Returns a copy of this [User] with the given values updated.
  User copyWith({
    auth.User? authUser,
    data.User? dataUser,
  }) {
    return User(
      authUser: authUser ?? this.authUser,
      dataUser: dataUser ?? this.dataUser,
    );
  }

  @override
  List<Object> get props => [id, authUser, dataUser];
}
