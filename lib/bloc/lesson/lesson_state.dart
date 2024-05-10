part of 'lesson_bloc.dart';

sealed class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object> get props => [];
}

final class LessonLoading extends LessonState {}

final class LessonLoaded extends LessonState {
  final List<LessonModel> lessonList;

  const LessonLoaded({
    required this.lessonList,
  });

  @override
  List<Object> get props => [lessonList];
}
