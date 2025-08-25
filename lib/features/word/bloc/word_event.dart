part of 'word_bloc.dart';

class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

final class WordInitRequested extends WordEvent {
  final User user;
  final String levelId;
  final String lessonId;

  const WordInitRequested({
    required this.user,
    required this.levelId,
    required this.lessonId,
  });
}

final class WordAddUserWordRequested extends WordEvent {
  final User user;
  final String levelId;
  final String lessonId;

  const WordAddUserWordRequested({
    required this.user,
    required this.levelId,
    required this.lessonId,
  });
}

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
