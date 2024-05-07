import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  final TranslateRepository _translateRepository;

  TranslateBloc({
    required TranslateRepository translateRepository,
  })  : _translateRepository = translateRepository,
        super(TranslateInitial()) {
    on<TranslateWord>(_onTranslateWord);
    on<EditWord>(_onEditWord);
    on<UpdateEnglish>(_onUpdateEnglish);
    on<UpdateSpanish>(_onUpdateSpanish);
    on<UpdateGerman>(_onUpdateGerman);
  }

  void _onTranslateWord(TranslateWord event, emit) async {
    final List<String> languages = ["en", "de", "es"];
    final List<String> translatedWordList = [];

    emit(TranslateLoading());
    for (String lang in languages) {
      final result = await _translateRepository.translateWord(
        event.word,
        lang,
      );

      final word = jsonDecode(result)["translations"][0]["text"];
      translatedWordList.add(word);
    }

    emit(TranslateLoaded(
      translatedWordList: translatedWordList,
    ));
  }

  void _onEditWord(EditWord event, emit) {
    final state = this.state as TranslateLoaded;

    emit(state.copyWith(
      isEdit: event.isEdit,
    ));
  }

  void _onUpdateEnglish(UpdateEnglish event, emit) {
    final state = this.state as TranslateLoaded;
    state.translatedWordList[0] = event.word;

    emit(state.copyWith(
      translatedWordList: state.translatedWordList,
    ));
  }

  void _onUpdateSpanish(UpdateSpanish event, emit) {
    final state = this.state as TranslateLoaded;
    state.translatedWordList[1] = event.word;

    emit(state.copyWith(
      translatedWordList: state.translatedWordList,
    ));
  }

  void _onUpdateGerman(UpdateGerman event, emit) {
    final state = this.state as TranslateLoaded;
    state.translatedWordList[2] = event.word;

    emit(state.copyWith(
      translatedWordList: state.translatedWordList,
    ));
  }
}
