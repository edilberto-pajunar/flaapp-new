part of 'lesson_bloc.dart';

final class LessonState extends Equatable {
  final List<LessonModel> lessons;
  final List<LessonModel> userLessons;

  const LessonState({
    this.lessons = const [],
    this.userLessons = const [],
  });

  LessonState copyWith({
    List<LessonModel>? lessons,
    List<LessonModel>? userLessons,
  }) {
    return LessonState(
      lessons: lessons ?? this.lessons,
      userLessons: userLessons ?? this.userLessons,
    );
  }

  @override
  List<Object> get props => [
        lessons,
        userLessons,
      ];
}
