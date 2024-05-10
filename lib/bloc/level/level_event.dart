part of 'level_bloc.dart';

class LevelEvent extends Equatable {
  const LevelEvent();

  @override
  List<Object> get props => [];
}

class LevelLoad extends LevelEvent {
  final List<LevelModel> levelList;

  const LevelLoad({
    required this.levelList,
  });

  @override
  List<Object> get props => [levelList];
}
