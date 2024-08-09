part of 'word_bloc.dart';

class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

final class WordInitRequested extends WordEvent {
  final String level;
  final String lesson;

  const WordInitRequested({
    required this.level,
    required this.lesson,
  });
}

final class WordLoadedRequested extends WordEvent {
  final String level;
  final String lesson;

  const WordLoadedRequested({
    required this.level,
    required this.lesson,
  });
}

final class WordFlipCardTapped extends WordEvent {}

final class WordCardUpdateDragged extends WordEvent {
  final DragUpdateDetails details;

  const WordCardUpdateDragged({
    required this.details,
  });
}

final class WordCardEndDragged extends WordEvent {
  final DraggableDetails details;
  final WordModel word;

  const WordCardEndDragged({
    required this.details,
    required this.word,
  });
}

final class WordBoxTapped extends WordEvent {
  final int boxIndex;

  const WordBoxTapped({
    required this.boxIndex,
  });
}

final class WordLockedCardTriggered extends WordEvent {
  const WordLockedCardTriggered();
}

final class WordTimerInitRequested extends WordEvent {
  final List<WordModel> words;

  const WordTimerInitRequested({
    required this.words,
  });
}

final class WordCompleteTriggered extends WordEvent {}

final class WordFailedTriggered extends WordEvent {
  final String error;

  const WordFailedTriggered({
    required this.error,
  });
}

final class WordSpeakRequested extends WordEvent {
  final String frontWord;
  final String backWord;

  const WordSpeakRequested({
    required this.frontWord,
    required this.backWord,
  });
}
