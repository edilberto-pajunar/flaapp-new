part of 'language_bloc.dart';

enum LanguageStatus {
  initial,
  loading,
  success,
  failed,
}

class LanguageState extends Equatable {
  final List<LanguageModel> languages;
  final LanguageStatus status;
  final LanguageModel selectedLanguage;
  final String error;

  const LanguageState({
    this.languages = const [],
    this.status = LanguageStatus.initial,
    this.selectedLanguage = const LanguageModel(),
    this.error = '',
  });

  LanguageState copyWith({
    List<LanguageModel>? languages,
    LanguageStatus? status,
    LanguageModel? selectedLanguage,
    String? error,
  }) =>
      LanguageState(
        languages: languages ?? this.languages,
        status: status ?? this.status,
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [languages, status, selectedLanguage, error];
}
