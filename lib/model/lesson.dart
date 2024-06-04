import 'package:equatable/equatable.dart';

class LessonModel extends Equatable {
  final String label;
  final String level;
  final bool locked;
  final String? id;

  const LessonModel({
    required this.label,
    required this.level,
    this.locked = true,
    this.id,
  });

  LessonModel copyWith({
    String? label,
    String? level,
    bool? locked,
    String? id,
  }) =>
      LessonModel(
        label: label ?? this.label,
        level: level ?? this.level,
        locked: locked ?? this.locked,
        id: id ?? this.id,
      );

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        label: json["label"],
        level: json["level"],
        locked: json["locked"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "level": level,
        "locked": locked,
        "id": id,
      };

  @override
  List<Object?> get props => [
        label,
        level,
        locked,
        id,
      ];
}
