import 'dart:async';
import 'dart:developer';

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
  final AuthBloc _authBloc;
  StreamSubscription? _lessonSubscription;
  final String level;

  LessonBloc({
    required DatabaseRepository databaseRepository,
    required LevelBloc levelBloc,
    required this.level,
    required AuthBloc authBloc,
  })  : _databaseRepository = databaseRepository,
        _authBloc = authBloc,
        super(LessonLoading()) {
    on<LessonStarted>(_onLessonStarted);
    on<LessonLoad>(_onLessonLoad);
    on<LessonUnlock>(_onLessonUnlock);

    _lessonSubscription = _databaseRepository.getUserLessons(_authBloc.state.user!.uid, level).listen((lessons) {
      add(LessonLoad(lessonList: lessons));

      log("$lessons");
    });
  }

  void _onLessonStarted(LessonStarted event, emit) async {
    // final String id = _authBloc.state.user!.uid;
    // await _databaseRepository
    //     .getUserLessons(
    //       id,
    //       level,
    //     )
    //     .first
    //     .then((lessonList) {
    //   add(LessonLoad(lessonList: lessonList));
    // });
  }

  void _onLessonLoad(LessonLoad event, emit) async {
    // final List<LessonModel> updatedList = [];
    // for (LessonModel lesson in event.lessonList) {
    //   await _databaseRepository.getUserWords(_authBloc.state.user!.uid, level, lesson.label).first.then((wordList) {
    //     final LessonModel updatedLesson = lesson.copyWith(
    //       locked: wordList.any((element) => element.box == 4) ? false : true,
    //     );

    //     updatedList.add(updatedLesson);
    //   });
    // }

    emit(LessonLoaded(lessonList: event.lessonList));
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
