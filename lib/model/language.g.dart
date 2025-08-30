// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) =>
    LanguageModel(
      id: json['id'] as String?,
      language: json['language'] as String?,
      code: json['code'] as String?,
      createdAt: timestampToDate(json['createdAt'] as Timestamp?),
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$LanguageModelToJson(LanguageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': instance.language,
      'code': instance.code,
      'createdAt': dateToTimestamp(instance.createdAt),
      'flag': instance.flag,
    };
