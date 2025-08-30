part of 'level_bloc.dart';

class LevelEvent extends Equatable {
  const LevelEvent();

  @override
  List<Object> get props => [];
}

class LevelInitRequested extends LevelEvent {
  const LevelInitRequested();
}

class LevelAddUserLevelRequested extends LevelEvent {
  final String levelId;

  const LevelAddUserLevelRequested({
    required this.levelId,
  });
}
