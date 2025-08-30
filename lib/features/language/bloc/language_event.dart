part of 'language_bloc.dart';

class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageInitRequested extends LanguageEvent {
  const LanguageInitRequested();
}

class LanguageSelected extends LanguageEvent {
  final LanguageModel language;

  const LanguageSelected({
    required this.language,
  });
}

class LanguageChangeRequested extends LanguageEvent {
  final LanguageModel language;

  const LanguageChangeRequested({
    required this.language,
  });
}

class LanguageAddRequested extends LanguageEvent {
  final LanguageModel language;

  const LanguageAddRequested({
    required this.language,
  });
}
