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

final class WordLockedCardTriggered extends WordEvent {
  const WordLockedCardTriggered();
}

final class WordTimerInitRequested extends WordEvent {
  final List<WordModel> words;

  const WordTimerInitRequested({
    required this.words,
  });
}

final class WordCompleted extends WordEvent {
  final String userId;
  final String levelId;
  final String lessonId;

  const WordCompleted({
    required this.userId,
    required this.levelId,
    required this.lessonId,
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

class WordFavoriteAdded extends WordEvent {
  final WordModel word;

  const WordFavoriteAdded({
    required this.word,
  });
}
