// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      label: json['label'] as String?,
      levelId: json['levelId'] as String?,
      locked: json['locked'] as bool? ?? true,
      id: json['id'] as String?,
      status: $enumDecodeNullable(_$LessonStatusEnumMap, json['status']) ??
          LessonStatus.notStarted,
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'levelId': instance.levelId,
      'locked': instance.locked,
      'id': instance.id,
      'status': _$LessonStatusEnumMap[instance.status],
    };

const _$LessonStatusEnumMap = {
  LessonStatus.notStarted: 'notStarted',
  LessonStatus.inProgress: 'inProgress',
  LessonStatus.completed: 'completed',
};
