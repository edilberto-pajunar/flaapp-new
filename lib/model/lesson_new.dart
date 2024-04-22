import 'package:equatable/equatable.dart';
import 'package:flaapp/model/word.dart';

class LessonNewModel extends Equatable {
  final String label;
  final bool locked;

  const LessonNewModel({
    required this.label,
    this.locked = true,
  });

  LessonNewModel copyWith({
    String? label,
    bool? locked,
  }) =>
      LessonNewModel(
        label: label ?? this.label,
        locked: locked ?? this.locked,
      );

  factory LessonNewModel.fromJson(Map<String, dynamic> json) => LessonNewModel(
        label: json["label"],
        locked: json["locked"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "locked": locked,
      };

  @override
  List<Object?> get props => [label, locked];

  static List<LessonNewModel> lessonList = [
    const LessonNewModel(label: "Greetings and Farewells", locked: false),
    const LessonNewModel(label: "Personal and Information"),
  ];
}
