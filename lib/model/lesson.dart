import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

enum LessonStatus {
  notStarted,
  inProgress,
  completed,
}

@JsonSerializable(explicitToJson: true)
class LessonModel extends Equatable {
  final String? label;
  final String? levelId;
  final bool? locked;
  final String? id;
  final LessonStatus? status;

  const LessonModel({
    this.label,
    this.levelId,
    this.locked = true,
    this.id,
    this.status = LessonStatus.notStarted,
  });

  LessonModel copyWith({
    String? label,
    String? levelId,
    bool? locked,
    String? id,
    LessonStatus? status,
  }) =>
      LessonModel(
        label: label ?? this.label,
        levelId: levelId ?? this.levelId,
        locked: locked ?? this.locked,
        id: id ?? this.id,
        status: status ?? this.status,
      );

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  @override
  List<Object?> get props => [
        label,
        levelId,
        locked,
        id,
        status,
      ];
}
