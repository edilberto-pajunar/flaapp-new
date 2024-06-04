part of 'app_bloc.dart';

class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInitRequested extends AppEvent {}

class AppInitAuthStreamRequested extends AppEvent {}

class AppInitUserInfoStreamRequested extends AppEvent {
  final User user;

  const AppInitUserInfoStreamRequested(this.user);
}
