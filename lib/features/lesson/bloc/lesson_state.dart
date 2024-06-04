part of 'lesson_bloc.dart';

final class LessonState extends Equatable {
  final List<LessonModel> lessons;

  const LessonState({
    this.lessons = const [],
  });

  LessonState copyWith({
    List<LessonModel>? lessons,
  }) {
    return LessonState(
      lessons: lessons ?? this.lessons,
    );
  }

  @override
  List<Object> get props => [lessons];
}
