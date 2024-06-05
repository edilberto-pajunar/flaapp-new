part of 'word_bloc.dart';

class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

final class WordInitRequested extends WordEvent {
  final User user;
  final String level;
  final String lesson;

  const WordInitRequested({
    required this.user,
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
  final User user;

  const WordCardEndDragged({
    required this.details,
    required this.word,
    required this.user,
  });
}

final class WordBoxTapped extends WordEvent {
  final int boxIndex;

  const WordBoxTapped({
    required this.boxIndex,
  });
}

final class WordLockedCardTriggered extends WordEvent {
  final User user;

  const WordLockedCardTriggered({
    required this.user,
  });
}

final class WordTimerInitRequested extends WordEvent {
  final User user;

  const WordTimerInitRequested({
    required this.user,
  });
}

