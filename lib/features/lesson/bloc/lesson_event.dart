part of 'lesson_bloc.dart';

final class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

final class LessonInitRequested extends LessonEvent {
  final User user;
  final String levelId;

  const LessonInitRequested({
    required this.user,
    required this.levelId,
  });
}

final class LessonAddUserLessonRequested extends LessonEvent {
  final User user;
  final String levelId;
  final String lessonId;

  const LessonAddUserLessonRequested({
    required this.user,
    required this.levelId,
    required this.lessonId,
  });
}

final class LessonUnlockTriggered extends LessonEvent {
  final User user;
  final List<LessonModel> lessons;
  final LessonModel lesson;

  const LessonUnlockTriggered({
    required this.user,
    required this.lessons,
    required this.lesson,
  });
}
