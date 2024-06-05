part of 'word_bloc.dart';

enum SwipeStatus { idle, loading, success, failed }

final class WordState extends Equatable {
  final List<WordModel> words;
  final bool frontVisible;
  final double position;
  final int boxIndex;
  final SwipeStatus swipeStatus;
  final int? lockedTime;

  const WordState({
    this.words = const [],
    this.frontVisible = true,
    this.position = 0.0,
    this.boxIndex = 0,
    this.swipeStatus = SwipeStatus.idle,
    this.lockedTime,
  });

  WordState copyWith({
    List<WordModel>? words,
    bool? frontVisible,
    double? position,
    int? boxIndex,
    SwipeStatus? swipeStatus,
    int? lockedTime,
  }) {
    return WordState(
      words: words ?? this.words,
      frontVisible: frontVisible ?? this.frontVisible,
      position: position ?? this.position,
      boxIndex: boxIndex ?? this.boxIndex,
      swipeStatus: swipeStatus ?? this.swipeStatus,
      lockedTime: lockedTime ?? this.lockedTime,
    );
  }

  @override
  List<Object?> get props => [
        words,
        frontVisible,
        position,
        boxIndex,
        swipeStatus,
        lockedTime,
      ];
}
