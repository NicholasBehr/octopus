import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    String? name,
    String? email,
    bool? emailVerified,
  })  : name = name ?? '',
        email = email ?? '',
        emailVerified = emailVerified ?? false,
        assert(id != '', 'id cannot be empty');

  /// The unique identifier of the 'user'.
  ///
  /// Cannot be empty
  final String id;

  /// The name associated with the 'user'.
  ///
  /// Note that the displayName may be empty.
  final String name;

  /// The email associated with the 'user'.
  ///
  /// Note that the email may be empty.
  final String email;

  /// Is the email of the user verified?
  ///
  /// Defaults to 'false'.
  final bool emailVerified;

  @override
  List<Object> get props => [id, name, email, emailVerified];
}
