part of 'word_bloc.dart';

sealed class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

class LoadUserWords extends WordEvent {
  final String userId;

  const LoadUserWords({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class UpdateBox extends WordEvent {
  final int boxIndex;

  const UpdateBox({
    required this.boxIndex,
  });
  @override
  List<Object> get props => [boxIndex];
}

class UpdateFrontSide extends WordEvent {
  const UpdateFrontSide();

  @override
  List<Object> get props => [];
}

class DragPosition extends WordEvent {
  final DragUpdateDetails details;

  const DragPosition({
    required this.details,
  });

  @override
  List<Object> get props => [details];
}

class EndPosition extends WordEvent {
  const EndPosition();

  @override
  List<Object> get props => [];
}
