part of 'level_bloc.dart';

final class LevelState extends Equatable {
  final List<LevelModel> levels;
  final List<LevelModel> userLevels;

  const LevelState({
    this.levels = const [],
    this.userLevels = const [],
  });

  LevelState copyWith({
    List<LevelModel>? levels,
    List<LevelModel>? userLevels,
  }) {
    return LevelState(
      levels: levels ?? this.levels,
      userLevels: userLevels ?? this.userLevels,
    );
  }

  @override
  List<Object> get props => [
        levels,
        userLevels,
      ];
}
