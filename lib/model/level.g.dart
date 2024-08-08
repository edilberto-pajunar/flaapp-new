// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelModel _$LevelModelFromJson(Map<String, dynamic> json) => LevelModel(
      label: json['label'] as String,
      locked: json['locked'] as bool? ?? true,
      id: json['id'] as String,
    );

Map<String, dynamic> _$LevelModelToJson(LevelModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'locked': instance.locked,
      'id': instance.id,
    };
