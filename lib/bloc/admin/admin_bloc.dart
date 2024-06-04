import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? wordStream;
  StreamSubscription? levelStream;

  AdminBloc({
    required DatabaseRepository databaseRepository,
    required TranslateRepository translateRepository,
  })  : _databaseRepository = databaseRepository,
        super(AdminLoading()) {
    on<UpdateHome>(_onUpdateHome);
    on<GetLevels>(_onGetLevels);
    on<UpdateWords>(_onUpdateWords);
    on<AddLevel>(_onAddLevel);
    on<AddLesson>(_onAddLesson);
    on<UpdateLevel>(_onUpdateLevel);
    on<UpdateLesson>(_onUpdateLesson);

    levelStream = _databaseRepository.getLevels(null).listen((levelList) {
      add(UpdateHome(levelList: levelList));
    });
  }

  void _onUpdateHome(UpdateHome event, emit) {
    emit(AdminLoaded(
      levelList: event.levelList,
    ));
  }

  void _onGetLevels(GetLevels event, emit) async {
    await _databaseRepository.getLevels(null).first.then((levels) {
      emit(AdminLoaded(
        wordList: const [],
        levelList: levels,
        lessonList: const [],
      ));
    });
  }

  void _onUpdateWords(UpdateWords event, emit) async {
    try {
      final state = this.state as AdminLoaded;
      if (state.level != null && state.lesson != null) {
        await _databaseRepository.getWords(null, state.level!, state.lesson!).first.then((wordList) {
          emit(state.copyWith(
            wordList: wordList,
          ));
        });
      }
    } catch (e) {}
  }

  void _onAddLevel(AddLevel event, emit) async {
    await _databaseRepository.addLevel(event.level);
  }

  void _onAddLesson(AddLesson event, emit) async {
    await _databaseRepository.addLesson(event.lesson);
  }

  void _onUpdateLevel(UpdateLevel event, emit) async {
    final state = this.state as AdminLoaded;

    final lessons = await _databaseRepository.getLessons(null, event.level).first;
    emit(state.copyWith(
      level: event.level,
      lessonList: lessons,
      lesson: null,
    ));
  }

  void _onUpdateLesson(UpdateLesson event, emit) {
    final state = this.state as AdminLoaded;

    emit(state.copyWith(
      lesson: event.lesson,
    ));
  }

  @override
  Future<void> close() async {
    wordStream?.cancel();
    super.close();
  }
}
