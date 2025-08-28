import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

DateTime? timestampToDate(Timestamp? timestamp) => timestamp?.toDate();

Timestamp? dateToTimestamp(DateTime? date) =>
    date == null ? null : Timestamp.fromDate(date);

enum LessonStatus {
  @JsonValue("not_started")
  notStarted,

  @JsonValue("in_progress")
  inProgress,

  @JsonValue("completed")
  completed,
}

@JsonSerializable(explicitToJson: true)
class LessonModel extends Equatable {
  final String? label;
  final String? levelId;
  final bool? locked;
  final String? id;
  @JsonKey(unknownEnumValue: LessonStatus.notStarted)
  final LessonStatus? status;
  @JsonKey(fromJson: timestampToDate, toJson: dateToTimestamp)
  final DateTime? completedTime;

  const LessonModel({
    this.label,
    this.levelId,
    this.locked = true,
    this.id,
    this.status = LessonStatus.notStarted,
    this.completedTime,
  });

  LessonModel copyWith({
    String? label,
    String? levelId,
    bool? locked,
    String? id,
    LessonStatus? status,
    DateTime? completedTime,
  }) =>
      LessonModel(
        label: label ?? this.label,
        levelId: levelId ?? this.levelId,
        locked: locked ?? this.locked,
        id: id ?? this.id,
        status: status ?? this.status,
        completedTime: completedTime ?? this.completedTime,
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
        completedTime,
      ];
}
