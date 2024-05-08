// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataUser _$UserFromJson(Map<String, dynamic> json) => DataUser(
      hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
      ownAccounts: (json['ownAccounts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$UserToJson(DataUser instance) => <String, dynamic>{
      'hasCompletedOnboarding': instance.hasCompletedOnboarding,
      'ownAccounts': instance.ownAccounts,
    };
