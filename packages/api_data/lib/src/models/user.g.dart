// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
      ownAccounts: (json['ownAccounts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'hasCompletedOnboarding': instance.hasCompletedOnboarding,
      'ownAccounts': instance.ownAccounts,
    };
