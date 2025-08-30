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
    on<LevelAddUserLevelRequested>(_onAddUserLevelRequested);
  }

  void _onInitRequested(
    LevelInitRequested event,
    Emitter<LevelState> emit,
  ) async {
    final levels = await _levelRepository.getLevels();
    emit(state.copyWith(levels: levels));

    await emit.forEach(_levelRepository.getUserLevels(),
        onData: (userLevels) {
      // if user levels is empty, initialized a level
      if (userLevels.isEmpty) {
        add(LevelAddUserLevelRequested(
          levelId: state.levels.first.id ?? "",
        ));
      }

      return state.copyWith(userLevels: userLevels);
    });
  }

  void _onAddUserLevelRequested(
    LevelAddUserLevelRequested event,
    Emitter<LevelState> emit,
  ) async {
    await _levelRepository.addUserLevel(
      levelId: event.levelId,
    );
  }
}
