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
  }

  void _onUpdateHome(UpdateHome event, emit) {
    emit(AdminLoaded(
      wordList: event.wordList,
      levelList: event.levelList,
      lessonList: event.lessonList,
      level: state is AdminLoading ? null : (state as AdminLoaded).level,
      lesson: state is AdminLoading ? null : (state as AdminLoaded).lesson,
    ));
  }

  void _onGetLevels(GetLevels event, emit) async {
    await _databaseRepository.getLevels().first.then((levels) {
      emit(AdminLoaded(
        wordList: const [],
        levelList: levels,
        lessonList: const [],
      ));
    });
  }

  void _onUpdateWords(UpdateWords event, emit) {
    try {
      final state = this.state as AdminLoaded;
      if (state.level != null && state.lesson != null) {
        _databaseRepository.getAdminWords(state.level!, state.lesson!).listen((words) {
          add(UpdateHome(wordList: words, levelList: state.levelList, lessonList: state.lessonList));
        });
      }
    } catch (e) {}
  }

  void _onAddLevel(AddLevel event, emit) async {
    await _databaseRepository.updateLevel();
  }

  void _onAddLesson(AddLesson event, emit) async {
    await _databaseRepository.updateLesson();
  }

  void _onUpdateLevel(UpdateLevel event, emit) async {
    final state = this.state as AdminLoaded;

    final lessons = await _databaseRepository.getLessons(event.level);
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
}
