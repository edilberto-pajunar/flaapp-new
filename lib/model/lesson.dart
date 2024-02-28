import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/model/word.dart';

class LessonModel extends Equatable {
  final String doc;
  final bool locked;
  final DateTime? timeConstraint;
  final List<WordModel> words;

  const LessonModel({
    required this.doc,
    required this.locked,
    required this.words,
    this.timeConstraint,
  });

  LessonModel copyWith({
    String? doc,
    bool? locked,
    DateTime? timeConstraint,
    List<WordModel>? words,
  }) =>
      LessonModel(
        doc: doc ?? this.doc,
        locked: locked ?? this.locked,
        words: words ?? this.words,
        timeConstraint: timeConstraint ?? this.timeConstraint,
      );

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
    doc: json["doc"],
    locked: json["locked"],
    timeConstraint: (json["timeConstraint"] as Timestamp?)?.toDate(),
    words: List<WordModel>.from(json["words"].map((x) => WordModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "doc": doc,
    "locked": locked,
    "timeConstraint": timeConstraint != null
        ? Timestamp.fromDate(timeConstraint!)
        : null,
    "words": List<dynamic>.from(words.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [doc];
}
