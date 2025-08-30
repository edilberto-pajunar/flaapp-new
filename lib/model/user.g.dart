// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUserInfo _$AppUserInfoFromJson(Map<String, dynamic> json) => AppUserInfo(
      id: json['id'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      language: json['language'] as String?,
      code: json['code'] as String?,
      codeToLearn: json['codeToLearn'] as String?,
      role: json['role'] as String?,
      updatedTime: timestampToDate(json['updatedTime'] as Timestamp?),
    );

Map<String, dynamic> _$AppUserInfoToJson(AppUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'language': instance.language,
      'code': instance.code,
      'codeToLearn': instance.codeToLearn,
      'role': instance.role,
      'updatedTime': dateToTimestamp(instance.updatedTime),
    };
