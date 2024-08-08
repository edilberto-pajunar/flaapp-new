// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
      id: json['id'] as String,
      word: json['word'] as String,
      box: (json['box'] as num?)?.toInt() ?? 0,
      translations: (json['translations'] as List<dynamic>)
          .map((e) => Translation.fromJson(e as Map<String, dynamic>))
          .toList(),
      level: LevelModel.fromJson(json['level'] as Map<String, dynamic>),
      lesson: LessonModel.fromJson(json['lesson'] as Map<String, dynamic>),
      updateTime: timestampToDate(json['updateTime'] as Timestamp?),
      lockedTime: timestampToDate(json['lockedTime'] as Timestamp?),
    );

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'box': instance.box,
      'translations': instance.translations.map((e) => e.toJson()).toList(),
      'level': instance.level.toJson(),
      'lesson': instance.lesson.toJson(),
      'updateTime': dateToTimestamp(instance.updateTime),
      'lockedTime': dateToTimestamp(instance.lockedTime),
    };
