import 'package:equatable/equatable.dart';
import 'package:flaapp/model/level.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable(explicitToJson: true)
class LessonModel extends Equatable {
  final String label;
  final LevelModel level;
  final bool locked;
  final String id;

  const LessonModel({
    required this.label,
    required this.level,
    this.locked = true,
    required this.id,
  });

  LessonModel copyWith({
    String? label,
    LevelModel? level,
    bool? locked,
    String? id,
  }) =>
      LessonModel(
        label: label ?? this.label,
        level: level ?? this.level,
        locked: locked ?? this.locked,
        id: id ?? this.id,
      );

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  @override
  List<Object?> get props => [
        label,
        level,
        locked,
        id,
      ];
}
