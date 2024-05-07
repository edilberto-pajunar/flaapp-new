part of 'translate_bloc.dart';

sealed class TranslateEvent extends Equatable {
  const TranslateEvent();

  @override
  List<Object> get props => [];
}

class TranslateWord extends TranslateEvent {
  final String word;

  const TranslateWord({
    required this.word,
  });

  @override
  List<Object> get props => [word];
}

class EditWord extends TranslateEvent {
  final bool isEdit;

  const EditWord({
    required this.isEdit,
  });

  @override
  List<Object> get props => [isEdit];
}

class UpdateEnglish extends TranslateEvent {
  final String word;

  const UpdateEnglish({
    required this.word,
  });

  @override
  List<Object> get props => [word];
}

class UpdateGerman extends TranslateEvent {
  final String word;

  const UpdateGerman({
    required this.word,
  });

  @override
  List<Object> get props => [word];
}

class UpdateSpanish extends TranslateEvent {
  final String word;

  const UpdateSpanish({
    required this.word,
  });

  @override
  List<Object> get props => [word];
}
