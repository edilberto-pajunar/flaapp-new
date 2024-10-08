import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonRepository _lessonRepository;

  LessonBloc({
    required LessonRepository lessonRepository,
  })  : _lessonRepository = lessonRepository,
        super(const LessonState()) {
    on<LessonInitRequested>(_onInitRequested);
    on<LessonUnlockTriggered>(_onUnlockTriggered);
  }

  void _onInitRequested(
    LessonInitRequested event,
    Emitter<LessonState> emit,
  ) async {
    await emit.forEach(
        _lessonRepository.getLessons(event.user.uid, event.level),
        onData: (lessons) => state.copyWith(
              lessons: lessons,
            ));
  }

  void _onUnlockTriggered(
    LessonUnlockTriggered event,
    Emitter<LessonState> emit,
  ) async {
    final int currentLessonIndex = event.lessons.indexOf(event.lesson);

    await _lessonRepository.unlockLesson(
      event.user.uid,
      event.lessons[currentLessonIndex + 1],
    );
  }
}
