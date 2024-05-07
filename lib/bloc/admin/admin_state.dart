part of 'admin_bloc.dart';

sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}


final class AdminLoading extends AdminState {}

final class AdminLoaded extends AdminState {
  final List<WordNewModel> wordList;
  final List<LevelModel> levelList;
  final List<LessonModel> lessonList;
  final String? level;
  final String? lesson;

  const AdminLoaded({
    required this.wordList,
    required this.levelList,
    required this.lessonList,
    this.level,
    this.lesson,
  });

  @override
  List<Object?> get props => [
        wordList,
        levelList,
        lessonList,
        level,
        lesson,
      ];

  AdminLoaded copyWith({
    List<LevelModel>? levelList,
    List<LessonModel>? lessonList,
    String? level,
    String? lesson,
  }) {
    return AdminLoaded(
      wordList: wordList,
      levelList: levelList ?? this.levelList,
      lessonList: lessonList ?? this.lessonList,
      level: level ?? this.level,
      lesson: lesson ?? this.lesson,
    );
  }
}
