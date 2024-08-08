import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/level/level_repository.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  final LevelRepository _levelRepository;
  

  LevelBloc({
    required LevelRepository levelRepository,
  })  : _levelRepository = levelRepository,
        super(const LevelState()) {
    on<LevelInitRequested>(_onInitRequested);
  }

  void _onInitRequested(
    LevelInitRequested event,
    Emitter<LevelState> emit,
  ) async {
    await emit.forEach(_levelRepository.getLevels(event.user.uid),
        onData: (levels) {
      return state.copyWith(levels: levels);
    });
  }
}
