part of 'word_bloc.dart';

enum WordLoadingStatus { idle, loading, success, failed }

enum WordFavoriteStatus {
  idle,
  loading,
  success,
  failed,
}

final class WordState extends Equatable {
  final List<WordModel> words;
  final List<WordModel> userWords;
  final bool frontVisible;
  final double position;
  final int boxIndex;
  final int? lockedTime;
  final String error;
  final WordLoadingStatus wordLoadingStatus;
  final WordFavoriteStatus wordFavoriteStatus;
  const WordState({
    this.words = const [],
    this.userWords = const [],
    this.frontVisible = true,
    this.position = 0.0,
    this.boxIndex = 0,
    this.lockedTime,
    this.error = "",
    this.wordLoadingStatus = WordLoadingStatus.idle,
    this.wordFavoriteStatus = WordFavoriteStatus.idle,
  });

  WordState copyWith({
    List<WordModel>? words,
    List<WordModel>? userWords,
    bool? frontVisible,
    double? position,
    int? boxIndex,
    int? lockedTime,
    String? error,
    WordLoadingStatus? wordLoadingStatus,
    WordFavoriteStatus? wordFavoriteStatus,
  }) {
    return WordState(
      words: words ?? this.words,
      userWords: userWords ?? this.userWords,
      frontVisible: frontVisible ?? this.frontVisible,
      position: position ?? this.position,
      boxIndex: boxIndex ?? this.boxIndex,
      lockedTime: lockedTime ?? this.lockedTime,
      error: error ?? this.error,
      wordLoadingStatus: wordLoadingStatus ?? this.wordLoadingStatus,
      wordFavoriteStatus: wordFavoriteStatus ?? this.wordFavoriteStatus,
    );
  }

  @override
  List<Object?> get props => [
        words,
        userWords,
        frontVisible,
        position,
        boxIndex,
        lockedTime,
        error,
        wordLoadingStatus,
        wordFavoriteStatus,
      ];
}
