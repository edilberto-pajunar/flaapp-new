part of 'level_bloc.dart';

sealed class LevelState extends Equatable {
  const LevelState();

  @override
  List<Object> get props => [];
}

final class LevelLoading extends LevelState {}

final class LevelLoaded extends LevelState {
  final List<LevelModel> levelList;

  const LevelLoaded({
    required this.levelList,
  });

  @override
  List<Object> get props => [levelList];
}
