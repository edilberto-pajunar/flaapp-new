import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/database/database_repository.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _levelSubscription;
  final AuthBloc _authBloc;

  LevelBloc({
    required DatabaseRepository databaseRepository,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(LevelLoading()) {
    on<LevelLoad>(_onLevelLoad);

    _levelSubscription = _databaseRepository.getUserLevels(_authBloc.state.user!.uid).listen((levels) {
      add(LevelLoad(levelList: levels));
    });
  }

  void _onLevelLoad(LevelLoad event, emit) {
    emit(LevelLoaded(levelList: event.levelList));
  }

  @override
  Future<void> close() async {
    _levelSubscription?.cancel();
    super.close();
  }
}
