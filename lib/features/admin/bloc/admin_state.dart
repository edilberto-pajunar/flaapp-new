part of 'admin_bloc.dart';

final class AdminState extends Equatable {
  final List<LevelModel> levels;
  final List<LessonModel> lessons;
  final List<WordModel> words;
  final String? level;
  final String? lesson;
  final List<String> translatedWords;

  const AdminState({
    this.levels = const [],
    this.lessons = const [],
    this.words = const [],
    this.level,
    this.lesson,
    this.translatedWords = const [],
  });

  @override
  List<Object?> get props => [
        levels,
        lessons,
        words,
        level,
        lesson,
        translatedWords,
      ];

  AdminState copyWith({
    List<LevelModel>? levels,
    List<LessonModel>? lessons,
    List<WordModel>? words,
    String? level,
    String? lesson,
    List<String>? translatedWords,
  }) {
    return AdminState(
      levels: levels ?? this.levels,
      lessons: lessons ?? this.lessons,
      words: words ?? this.words,
      level: level ?? this.level,
      lesson: lesson ?? this.lesson,
      translatedWords: translatedWords ?? this.translatedWords,
    );
  }
}
