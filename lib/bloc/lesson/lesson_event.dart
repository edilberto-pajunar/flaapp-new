part of 'lesson_bloc.dart';

sealed class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

class LessonLoad extends LessonEvent {
  final List<LessonModel> lessonList;

  const LessonLoad({
    required this.lessonList,
  });

  @override
  List<Object> get props => [lessonList];
}

class LessonUnlock extends LessonEvent {
  final LessonModel lesson;

  const LessonUnlock({
    required this.lesson,
  });

  @override
  List<Object> get props => [lesson];
}