import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    on<LessonAddUserLessonRequested>(_onAddUserLessonRequested);
    on<LessonUnlockTriggered>(_onUnlockTriggered);
  }

  void _onInitRequested(
    LessonInitRequested event,
    Emitter<LessonState> emit,
  ) async {
    final lessons = await _lessonRepository.getLessons(event.levelId);

    emit(state.copyWith(lessons: lessons));

    await emit.forEach(
      _lessonRepository.getUserLessons(
        level: event.levelId,
      ),
      onData: (userLessons) {
        if (userLessons.isEmpty) {
          add(LessonAddUserLessonRequested(
            levelId: event.levelId,
            lessonId: lessons.first.id ?? "",
          ));
        }
        return state.copyWith(userLessons: userLessons);
      },
    );
  }

  void _onAddUserLessonRequested(
    LessonAddUserLessonRequested event,
    Emitter<LessonState> emit,
  ) async {
    await _lessonRepository.addUserLesson(
      levelId: event.levelId,
      lessonId: event.lessonId,
    );
  }

  void _onUnlockTriggered(
    LessonUnlockTriggered event,
    Emitter<LessonState> emit,
  ) async {
    final int currentLessonIndex = event.lessons.indexOf(event.lesson);

    await _lessonRepository.unlockLesson(
      event.lessons[currentLessonIndex + 1],
    );
  }
}
