part of 'level_bloc.dart';

final class LevelState extends Equatable {
  final List<LevelModel> levels;

  const LevelState({
    this.levels = const [],
  });

  LevelState copyWith({
    List<LevelModel>? levels,
  }) {
    return LevelState(
      levels: levels ?? this.levels,
    );
  }

  @override
  List<Object> get props => [levels];
}
