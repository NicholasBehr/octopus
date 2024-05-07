import 'package:api_data/api_data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@immutable
@JsonSerializable()
class User extends Equatable {
  User({
    String? id,
    this.hasCompletedOnboarding = false,
    this.ownAccounts = const <String>[],
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v8();

  /// The unique identifier of the 'user'.
  ///
  /// Cannot be empty
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String id;

  /// Has the onboarding flow been completed/skipped by this user?
  ///
  /// Defaults to false.
  final bool hasCompletedOnboarding;

  /// List of account id's the user created / owns
  ///
  /// Defaults to emty list.
  final List<String> ownAccounts;

  /// Returns a copy of this `user` with the given values updated.
  User copyWith({
    String? id,
    bool? hasCompletedOnboarding,
    List<String>? ownAccounts,
  }) {
    return User(
      id: id ?? this.id,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      ownAccounts: ownAccounts ?? this.ownAccounts,
    );
  }

  /// Deserializes the given [JsonMap] into a [User].
  static User fromJson(String id, JsonMap json) =>
      _$UserFromJson(json).copyWith(id: id);

  /// Converts this [User] into a [JsonMap].
  JsonMap toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [id, hasCompletedOnboarding, ownAccounts];
}
