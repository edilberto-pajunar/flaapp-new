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
