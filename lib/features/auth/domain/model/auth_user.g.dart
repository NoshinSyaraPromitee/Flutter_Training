// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => AuthUser(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
);

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
};
