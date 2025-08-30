import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/model/language.dart';
import 'package:flaapp/repository/language/language_repository.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository _languageRepository;

  LanguageBloc({
    required LanguageRepository languageRepository,
  })  : _languageRepository = languageRepository,
        super(LanguageState()) {
    on<LanguageInitRequested>(_onLanguageInitRequested);
    on<LanguageSelected>(_onLanguageSelected);
    on<LanguageChangeRequested>(_onLanguageChangeRequested);
  }

  void _onLanguageInitRequested(
      LanguageInitRequested event, Emitter<LanguageState> emit) async {
    await emit.forEach(_languageRepository.getLanguages(),
        onData: (languages) => state.copyWith(languages: languages));
  }

  void _onLanguageSelected(
      LanguageSelected event, Emitter<LanguageState> emit) {
    emit(state.copyWith(selectedLanguage: event.language));
  }

  void _onLanguageChangeRequested(
      LanguageChangeRequested event, Emitter<LanguageState> emit) async {
    emit(state.copyWith(status: LanguageStatus.loading));
    try {
      await _languageRepository.changeLanguage(event.language);
      emit(state.copyWith(status: LanguageStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LanguageStatus.failed, error: e.toString()));
    }
  }
}
