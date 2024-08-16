import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/translation.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final LevelRepository _levelRepository;
  final LessonRepository _lessonRepository;
  final WordRepository _wordRepository;
  final TranslateRepository _translateRepository;

  AdminBloc({
    required LevelRepository levelRepository,
    required LessonRepository lessonRepository,
    required WordRepository wordRepository,
    required TranslateRepository translateRepository,
  })  : _levelRepository = levelRepository,
        _lessonRepository = lessonRepository,
        _wordRepository = wordRepository,
        _translateRepository = translateRepository,
        super(const AdminState()) {
    on<AdminInitRequested>(_onInitRequested);
    on<AdminLevelStreamRequested>(_onAdminLevelStreamRequested);
    on<AdminLessonStreamRequested>(_onAdminLessonStreamRequested);
    on<AdminWordStreamRequested>(_onAdminWordStreamRequested);
    on<AdminAddLevelSubmitted>(_onAddLevelSubmitted);
    on<AdminAddLessonSubmitted>(_onAddLessonSubmitted);
    on<AdminAddWordSubmitted>(_onAddWordSubmitted);
    on<AdminTranslateWordRequested>(_onTranslateWordRequested);
    on<AdminDeleteLevelRequested>(_onDeleteLevelRequested);
    on<AdminDeleteLessonRequested>(_onDeleteLessonRequested);
    on<AdminDeleteWordRequested>(_onDeleteWordRequested);
    on<AdminLevelChanged>(_onLevelChanged);
    on<AdminLessonChanged>(_onLessonChanged);
    on<AdminWordChanged>(_onWordChanged);
  }

  void _onInitRequested(
    AdminInitRequested event,
    Emitter<AdminState> emit,
  ) async {
    add(const AdminLevelStreamRequested());
  }

  void _onAdminLevelStreamRequested(
    AdminLevelStreamRequested event,
    Emitter<AdminState> emit,
  ) async {
    await emit.forEach(_levelRepository.getAdminLevels(),
        onData: (levels) => state.copyWith(levels: levels));
  }

  void _onAdminLessonStreamRequested(
    AdminLessonStreamRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(state.copyWith(adminStatus: AdminStatus.loading));
    try {
      await emit.forEach(_lessonRepository.getAdminLessons(event.levelId),
          onData: (lessons) => state.copyWith(
                lessons: lessons,
                adminStatus: AdminStatus.success,
              ));
    } catch (e) {}
  }

  void _onAdminWordStreamRequested(
    AdminWordStreamRequested event,
    Emitter<AdminState> emit,
  ) async {
    emit(state.copyWith(adminStatus: AdminStatus.loading));

    try {
      await emit.forEach(
          _wordRepository.getAdminWords(
            level: event.levelId,
            lesson: event.lessonId,
          ),
          onData: (words) => state.copyWith(
                words: words,
                adminStatus: AdminStatus.success,
              ));
    } catch (e) {}
  }

  void _onAddLevelSubmitted(
    AdminAddLevelSubmitted event,
    Emitter<AdminState> emit,
  ) async {
    if (event.level.isEmpty) return;

    try {
      emit(state.copyWith(adminStatus: AdminStatus.loading));
      await _levelRepository.adminAddLevel(
        event.level.toLowerCase(),
      );
      emit(state.copyWith(adminStatus: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(adminStatus: AdminStatus.failed));
    }
  }

  void _onAddLessonSubmitted(
    AdminAddLessonSubmitted event,
    Emitter<AdminState> emit,
  ) async {
    if (event.lesson.isEmpty) return;

    try {
      emit(state.copyWith(adminStatus: AdminStatus.loading));
      await _lessonRepository.adminAddLesson(
        event.level,
        event.lesson.toLowerCase(),
      );

      emit(state.copyWith(adminStatus: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(adminStatus: AdminStatus.failed));
    }
  }

  void _onAddWordSubmitted(
    AdminAddWordSubmitted event,
    Emitter<AdminState> emit,
  ) async {
    try {
      emit(state.copyWith(adminStatus: AdminStatus.loading));

      await _wordRepository.adminAddWord(
        level: event.level,
        lesson: event.lesson,
        us: event.us.toLowerCase(),
        de: event.de.toLowerCase(),
        es: event.es.toLowerCase(),
      );

      emit(state.copyWith(adminStatus: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(adminStatus: AdminStatus.failed));
    }
  }

  void _onTranslateWordRequested(
    AdminTranslateWordRequested event,
    Emitter<AdminState> emit,
  ) async {
    if (event.word.isEmpty) return;
    final List<String> translatedWords = [];

    final german = await _translateRepository.translateWord(event.word, "de");
    final english = await _translateRepository.translateWord(event.word, "en");
    final spanish = await _translateRepository.translateWord(event.word, "es");

    translatedWords.addAll([english, german, spanish]);

    emit(state.copyWith(translatedWords: translatedWords));
  }

  void _onDeleteLevelRequested(
    AdminDeleteLevelRequested event,
    Emitter<AdminState> emit,
  ) async {
    try {
      emit(state.copyWith(adminStatus: AdminStatus.loading));
      await _levelRepository.deleteAdminLevel(event.level);
      emit(state.copyWith(adminStatus: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(adminStatus: AdminStatus.failed));
    }
  }

  void _onDeleteLessonRequested(
    AdminDeleteLessonRequested event,
    Emitter<AdminState> emit,
  ) async {
    try {
      emit(state.copyWith(adminStatus: AdminStatus.loading));
      await _lessonRepository.deleteAdminLesson(event.lesson);
      emit(state.copyWith(adminStatus: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(adminStatus: AdminStatus.failed));
    }
  }

  void _onDeleteWordRequested(
    AdminDeleteWordRequested event,
    Emitter<AdminState> emit,
  ) async {
    try {
      emit(state.copyWith(adminStatus: AdminStatus.loading));
      await _wordRepository.deleteWordLesson(event.word);
      emit(state.copyWith(adminStatus: AdminStatus.success));
    } catch (e) {
      emit(state.copyWith(adminStatus: AdminStatus.failed));
    }
  }

  void _onLevelChanged(
    AdminLevelChanged event,
    Emitter<AdminState> emit,
  ) async {
    await _levelRepository.updateAdminLevel(event.level);
  }

  void _onLessonChanged(
    AdminLessonChanged event,
    Emitter<AdminState> emit,
  ) async {
    await _lessonRepository.updateAdminLesson(event.lesson);
  }

  void _onWordChanged(
    AdminWordChanged event,
    Emitter<AdminState> emit,
  ) async {
    final updatedTranslations = List<Translation>.from(event.word.translations);
    updatedTranslations[event.index] =
        updatedTranslations[event.index].copyWith(
      word: event.updatedWord,
    );

    final updatedWord = event.word.copyWith(
      translations: updatedTranslations,
    );
    await _wordRepository.updateAdminWord(updatedWord);
  }
}
