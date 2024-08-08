part of 'admin_bloc.dart';

enum AdminType {
  levels,
  lessons,
  words,
}

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
  final LevelModel? level;
  final LessonModel? lesson;
  final List<String> translatedWords;
  final AdminType adminType;
  final AdminStatus adminStatus;

  const AdminState({
    this.levels = const [],
    this.lessons = const [],
    this.words = const [],
    this.level,
    this.lesson,
    this.translatedWords = const [],
    this.adminType = AdminType.levels,
    this.adminStatus = AdminStatus.idle,
  });

  AdminState copyWith({
    List<LevelModel>? levels,
    List<LessonModel>? lessons,
    List<WordModel>? words,
    LevelModel? level,
    LessonModel? lesson,
    List<String>? translatedWords,
    AdminType? adminType,
    AdminStatus? adminStatus,
  }) {
    return AdminState(
      levels: levels ?? this.levels,
      lessons: lessons ?? this.lessons,
      words: words ?? this.words,
      level: level ?? this.level,
      lesson: lesson ?? this.lesson,
      translatedWords: translatedWords ?? this.translatedWords,
      adminType: adminType ?? this.adminType,
      adminStatus: adminStatus ?? this.adminStatus,
    );
  }

  @override
  List<Object?> get props => [
        levels,
        lessons,
        words,
        level,
        lesson,
        translatedWords,
        adminType,
        adminStatus,
      ];
}
