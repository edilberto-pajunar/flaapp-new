part of 'admin_bloc.dart';

enum AdminStatus {
  idle,
  loading,
  success,
  failed,
}

final class AdminState extends Equatable {
  final List<LevelModel> levels;
  final List<LessonModel> lessons;
  final List<WordModel> words;
  final List<String> translatedWords;
  final AdminStatus adminStatus;

  const AdminState({
    this.levels = const [],
    this.lessons = const [],
    this.words = const [],
    this.translatedWords = const [],
    this.adminStatus = AdminStatus.idle,
  });

  AdminState copyWith({
    List<LevelModel>? levels,
    List<LessonModel>? lessons,
    List<WordModel>? words,
    LevelModel? level,
    LessonModel? lesson,
    List<String>? translatedWords,
    AdminStatus? adminStatus,
  }) {
    return AdminState(
      levels: levels ?? this.levels,
      lessons: lessons ?? this.lessons,
      words: words ?? this.words,
      translatedWords: translatedWords ?? this.translatedWords,
      adminStatus: adminStatus ?? this.adminStatus,
    );
  }

  @override
  List<Object?> get props => [
        levels,
        lessons,
        words,
        translatedWords,
        adminStatus,
      ];
}
