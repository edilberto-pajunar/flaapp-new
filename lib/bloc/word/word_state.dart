part of 'word_bloc.dart';

class WordState extends Equatable {
  @override
  List<Object> get props => [];
}

final class WordLoading extends WordState {}

final class WordLoaded extends WordState {
  final List<WordNewModel> userWords;
  final int boxIndex;
  final bool isFrontSide;
  final Offset position;

  WordLoaded({
    required this.userWords,
    this.boxIndex = 0,
    this.isFrontSide = true,
    this.position = Offset.zero,
  });

  @override
  List<Object> get props => [userWords, boxIndex, isFrontSide, position];
}
