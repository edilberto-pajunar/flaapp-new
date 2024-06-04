part of 'admin_bloc.dart';

sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

final class AdminLoading extends AdminState {}

final class AdminLoaded extends AdminState {
  final List<LevelModel> levelList;
  final List<LessonModel>? lessonList;
  final List<WordModel>? wordList;
  final String? level;
  final String? lesson;

  const AdminLoaded({
    required this.levelList,
    this.lessonList = const [],
    this.wordList = const [],
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
    List<WordModel>? wordList,
    String? level,
    String? lesson,
  }) {
    return AdminLoaded(
      levelList: levelList ?? this.levelList,
      lessonList: lessonList ?? this.lessonList,
      wordList: wordList ?? this.wordList,
      level: level ?? this.level,
      lesson: lesson ?? this.lesson,
    );
  }
}
