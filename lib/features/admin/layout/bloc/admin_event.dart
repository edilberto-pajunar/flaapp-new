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
  final LevelModel level;

  const AdminLessonStreamRequested({
    required this.level,
  });
}

class AdminWordStreamRequested extends AdminEvent {
  final String lesson;

  const AdminWordStreamRequested({
    required this.lesson,
  });
}

class AdminAddLevelSubmitted extends AdminEvent {
  final String level;

  const AdminAddLevelSubmitted({
    required this.level,
  });
}

class AdminAddLessonSubmitted extends AdminEvent {
  final LevelModel level;
  final String lesson;

  const AdminAddLessonSubmitted({
    required this.level,
    required this.lesson,
  });
}

class AdminAddWordSubmitted extends AdminEvent {
  final WordModel word;

  const AdminAddWordSubmitted({
    required this.word,
  });
}

class AdminTranslateWordRequested extends AdminEvent {
  final String word;

  const AdminTranslateWordRequested({
    required this.word,
  });
}

class AdminWordChanged extends AdminEvent {
  final String word;

  const AdminWordChanged({
    required this.word,
  });
}

class AdminTypeChanged extends AdminEvent {
  final AdminType adminType;
  final LevelModel? level;
  final LessonModel? lesson;

  const AdminTypeChanged({
    required this.adminType,
    this.level,
    this.lesson,
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
