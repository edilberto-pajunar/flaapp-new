import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/bloc/level/level_bloc.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/repository/database/database_repository.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _lessonSubscription;
  final String level;
  final AuthBloc _authBloc;

  LessonBloc({
    required DatabaseRepository databaseRepository,
    required LevelBloc levelBloc,
    required this.level,
    required AuthBloc authBloc,
  })  : _databaseRepository = databaseRepository,
        _authBloc = authBloc,
        super(LessonLoading()) {
    on<LessonLoad>(_onLessonLoad);
    on<LessonUnlock>(_onLessonUnlock);

    _lessonSubscription = _databaseRepository.getLessons(level).listen((lessons) {
      add(LessonLoad(lessonList: lessons));
    });
  }

  void _onLessonLoad(LessonLoad event, emit) async {
    final List<LessonModel> updatedList = [];
    for (LessonModel lesson in event.lessonList) {
      await _databaseRepository.getUserWords(_authBloc.state.user!.uid, level, lesson.label).first.then((wordList) {
        final LessonModel updatedLesson = lesson.copyWith(
          locked: wordList.any((element) => element.box == 4) ? false : true,
        );

        updatedList.add(updatedLesson);
      });
    }

    print(updatedList);

    emit(LessonLoaded(lessonList: updatedList));
  }

  void _onLessonUnlock(LessonUnlock event, emit) {
    final state = this.state as LessonLoaded;

    emit(LessonLoaded(lessonList: state.lessonList));
  }

  @override
  Future<void> close() async {
    _lessonSubscription?.cancel();
    super.close();
  }
}
