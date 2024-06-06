part of 'word_bloc.dart';

enum SwipeStatus { idle, loading, success, failed }

enum LockedStatus { locked, unlocked }

enum CompleteStatus { unfinished, finished }

final class WordState extends Equatable {
  final List<WordModel> words;
  final bool frontVisible;
  final double position;
  final int boxIndex;
  final SwipeStatus swipeStatus;
  final int? lockedTime;
  final LockedStatus lockedStatus;
  final CompleteStatus completeStatus;

  const WordState({
    this.words = const [],
    this.frontVisible = true,
    this.position = 0.0,
    this.boxIndex = 0,
    this.swipeStatus = SwipeStatus.idle,
    this.lockedTime,
    this.lockedStatus = LockedStatus.unlocked,
    this.completeStatus = CompleteStatus.unfinished,
  });

  WordState copyWith({
    List<WordModel>? words,
    bool? frontVisible,
    double? position,
    int? boxIndex,
    SwipeStatus? swipeStatus,
    int? lockedTime,
    LockedStatus? lockedStatus,
    CompleteStatus? completeStatus,
  }) {
    return WordState(
      words: words ?? this.words,
      frontVisible: frontVisible ?? this.frontVisible,
      position: position ?? this.position,
      boxIndex: boxIndex ?? this.boxIndex,
      swipeStatus: swipeStatus ?? this.swipeStatus,
      lockedTime: lockedTime ?? this.lockedTime,
      lockedStatus: lockedStatus ?? this.lockedStatus,
      completeStatus: completeStatus ?? this.completeStatus,
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
        lockedStatus,
        completeStatus,
      ];
}
