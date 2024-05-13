part of 'word_bloc.dart';

class WordState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WordLoading extends WordState {}

final class WordLoaded extends WordState {
  final List<WordNewModel> userWords;
  final int boxIndex;
  final bool isFrontSide;
  final double position;
  final String? duration;

  WordLoaded({
    required this.userWords,
    this.boxIndex = 0,
    this.isFrontSide = true,
    this.position = 0.0,
    this.duration,
  });

  @override
  List<Object?> get props => [
        userWords,
        boxIndex,
        isFrontSide,
        position,
        duration,
      ];
}

final class WordComplete extends WordState {}
