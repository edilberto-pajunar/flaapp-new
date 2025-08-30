part of 'lesson_bloc.dart';

final class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

final class LessonInitRequested extends LessonEvent {
  final String levelId;

  const LessonInitRequested({
    required this.levelId,
  });
}

final class LessonAddUserLessonRequested extends LessonEvent {
  final String levelId;
  final String lessonId;

  const LessonAddUserLessonRequested({
    required this.levelId,
    required this.lessonId,
  });
}

final class LessonUnlockTriggered extends LessonEvent {
  final List<LessonModel> lessons;
  final LessonModel lesson;

  const LessonUnlockTriggered({
    required this.lessons,
    required this.lesson,
  });
}
