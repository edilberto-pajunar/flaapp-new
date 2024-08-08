// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      label: json['label'] as String,
      level: LevelModel.fromJson(json['level'] as Map<String, dynamic>),
      locked: json['locked'] as bool? ?? true,
      id: json['id'] as String,
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'level': instance.level.toJson(),
      'locked': instance.locked,
      'id': instance.id,
    };
