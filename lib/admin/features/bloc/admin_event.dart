part of 'admin_bloc.dart';

class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class AdminInitRequested extends AdminEvent {
  const AdminInitRequested();
}

class AdminLevelStreamRequested extends AdminEvent {
  const AdminLevelStreamRequested();
}

class AdminLessonStreamRequested extends AdminEvent {
  final String levelId;

  const AdminLessonStreamRequested({
    required this.levelId,
  });
}

class AdminWordStreamRequested extends AdminEvent {
  final String levelId;
  final String lessonId;

  const AdminWordStreamRequested({
    required this.levelId,
    required this.lessonId,
  });
}

class AdminAddLevelSubmitted extends AdminEvent {
  final String level;
  final String description;

  const AdminAddLevelSubmitted({
    required this.level,
    required this.description,
  });
}

class AdminAddLessonSubmitted extends AdminEvent {
  final String levelId;
  final String lesson;
  final String description;

  const AdminAddLessonSubmitted({
    required this.levelId,
    required this.lesson,
    required this.description,
  });
}

class AdminAddWordSubmitted extends AdminEvent {
  final WordModel word;
  final String levelId;
  final String lessonId;

  const AdminAddWordSubmitted({
    required this.word,
    required this.levelId,
    required this.lessonId,
  });
}

class AdminTranslateWordRequested extends AdminEvent {
  final String word;

  const AdminTranslateWordRequested({
    required this.word,
  });
}

class AdminDeleteLevelRequested extends AdminEvent {
  final String level;

  const AdminDeleteLevelRequested(this.level);
}

class AdminDeleteLessonRequested extends AdminEvent {
  final String lesson;

  const AdminDeleteLessonRequested(this.lesson);
}

class AdminDeleteWordRequested extends AdminEvent {
  final String word;

  const AdminDeleteWordRequested(this.word);
}

class AdminLevelChanged extends AdminEvent {
  final LevelModel level;

  const AdminLevelChanged(this.level);
}

class AdminLessonChanged extends AdminEvent {
  final LessonModel lesson;

  const AdminLessonChanged(this.lesson);
}

class AdminWordChanged extends AdminEvent {
  final WordModel word;
  final String updatedWord;
  final int index;

  const AdminWordChanged({
    required this.word,
    required this.updatedWord,
    required this.index,
  });
}

class AdminLanguageStreamRequested extends AdminEvent {
  const AdminLanguageStreamRequested();
}
