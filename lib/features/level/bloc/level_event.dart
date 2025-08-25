part of 'level_bloc.dart';

class LevelEvent extends Equatable {
  const LevelEvent();

  @override
  List<Object> get props => [];
}

class LevelInitRequested extends LevelEvent {
  final User user;

  const LevelInitRequested({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class LevelAddUserLevelRequested extends LevelEvent {
  final String levelId;
  final String userId;

  const LevelAddUserLevelRequested({
    required this.levelId,
    required this.userId,
  });
}
