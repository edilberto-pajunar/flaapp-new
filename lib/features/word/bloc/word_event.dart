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
