part of 'lesson_bloc.dart';

final class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

final class LessonInitRequested extends LessonEvent {
  final User user;
  final String level;

  const LessonInitRequested({
    required this.user,
    required this.level,
  });
}
