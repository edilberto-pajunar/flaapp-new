part of 'admin_bloc.dart';

final class AdminState extends Equatable {
  final List<LevelModel> levels;
  final List<LessonModel> lessons;
  final List<WordModel> words;
  final String? level;
  final String? lesson;

  const AdminState({
    this.levels = const [],
    this.lessons = const [],
    this.words = const [],
    this.level,
    this.lesson,
  });

  @override
  List<Object?> get props => [
        levels,
        lessons,
        words,
        level,
        lesson,
      ];

  AdminState copyWith({
    List<LevelModel>? levels,
    List<LessonModel>? lessons,
    List<WordModel>? words,
    String? level,
    String? lesson,
  }) {
    return AdminState(
      levels: levels ?? this.levels,
      lessons: lessons ?? this.lessons,
      words: words ?? this.words,
      level: level ?? this.level,
      lesson: lesson ?? this.lesson,
    );
  }
}
