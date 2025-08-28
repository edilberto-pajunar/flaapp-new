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
      status: $enumDecodeNullable(_$LessonStatusEnumMap, json['status'],
              unknownValue: LessonStatus.notStarted) ??
          LessonStatus.notStarted,
      completedTime: timestampToDate(json['completedTime'] as Timestamp?),
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'levelId': instance.levelId,
      'locked': instance.locked,
      'id': instance.id,
      'status': _$LessonStatusEnumMap[instance.status],
      'completedTime': dateToTimestamp(instance.completedTime),
    };

const _$LessonStatusEnumMap = {
  LessonStatus.notStarted: 'not_started',
  LessonStatus.inProgress: 'in_progress',
  LessonStatus.completed: 'completed',
};
