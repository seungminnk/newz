// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      json['loginType'] as String,
      json['name'] as String,
      json['email'] as String,
      json['completeOnboarding'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'loginType': instance.loginType,
      'name': instance.name,
      'email': instance.email,
      'completeOnboarding': instance.completeOnboarding,
    };
