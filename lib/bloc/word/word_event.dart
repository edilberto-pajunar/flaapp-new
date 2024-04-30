part of 'word_bloc.dart';

sealed class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserWords extends WordEvent {
  final String userId;
  final String level;
  final String lesson;
  final String? localId;

  const LoadUserWords({
    required this.userId,
    required this.level,
    required this.lesson,
    this.localId,
  });

  @override
  List<Object?> get props => [userId, level, lesson, localId];
}

class UpdateHome extends WordEvent {
  final List<WordNewModel> wordList;
  final String? duration;

  const UpdateHome({
    required this.wordList,
    this.duration,
  });

  @override
  List<Object?> get props => [wordList, duration];
}

class UpdateBox extends WordEvent {
  final int boxIndex;

  const UpdateBox({
    required this.boxIndex,
  });
  @override
  List<Object?> get props => [boxIndex];
}

class UpdateFrontSide extends WordEvent {
  const UpdateFrontSide();

  @override
  List<Object?> get props => [];
}

class DragPosition extends WordEvent {
  final DragUpdateDetails details;

  const DragPosition({
    required this.details,
  });

  @override
  List<Object?> get props => [details];
}

class SwipeCard extends WordEvent {
  final WordNewModel currentWord;
  final List<WordNewModel> wordList;
  final String level;
  final String lesson;
  final bool swipeRight;

  const SwipeCard({
    required this.wordList,
    required this.currentWord,
    required this.swipeRight,
    required this.level,
    required this.lesson,
  });

  @override
  List<Object?> get props => [wordList, currentWord, swipeRight, level, lesson];
}
