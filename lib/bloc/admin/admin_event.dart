part of 'admin_bloc.dart';

class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class UpdateHome extends AdminEvent {
  final List<WordNewModel>? wordList;
  final List<LevelModel> levelList;
  final List<LessonModel>? lessonList;

  const UpdateHome({
    this.wordList,
    required this.levelList,
    this.lessonList,
  });

  @override
  List<Object?> get props => [wordList, levelList, lessonList];

  UpdateHome copyWith({
    List<WordNewModel>? wordList,
    List<LevelModel>? levelList,
    List<LessonModel>? lessonList,
  }) {
    return UpdateHome(
      wordList: wordList ?? this.wordList,
      levelList: levelList ?? this.levelList,
      lessonList: lessonList ?? this.lessonList,
    );
  }
}

class GetLevels extends AdminEvent {
  const GetLevels();

  @override
  List<Object> get props => [];
}

class AddLevel extends AdminEvent {
  const AddLevel();

  @override
  List<Object> get props => [];
}

class AddLesson extends AdminEvent {
  final LessonModel lessonModel;

  const AddLesson({
    required this.lessonModel,
  });

  @override
  List<Object> get props => [lessonModel];
}

class UpdateWords extends AdminEvent {
  const UpdateWords();

  @override
  List<Object> get props => [];
}

class UpdateLevel extends AdminEvent {
  final String level;

  const UpdateLevel({
    required this.level,
  });

  @override
  List<Object> get props => [level];
}

class UpdateLesson extends AdminEvent {
  final String lesson;

  const UpdateLesson({
    required this.lesson,
  });

  @override
  List<Object> get props => [lesson];
}
