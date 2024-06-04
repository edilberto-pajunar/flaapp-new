part of 'word_bloc.dart';

final class WordState extends Equatable {
  final List<WordModel> words;

  const WordState({
    this.words = const [],
  });

  WordState copyWith({
    List<WordModel>? words,
  }) {
    return WordState(
      words: words ?? this.words,
    );
  }

  @override
  List<Object> get props => [words];
}

final class WordInitial extends WordState {}
