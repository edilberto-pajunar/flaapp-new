import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;

  WordBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(WordLoading()) {
    on<LoadUserWords>(_onLoadUserWords);
    on<UpdateBox>(_onUpdateBox);
    on<UpdateFrontSide>(_onUpdateFrontSide);
    on<DragPosition>(_onDragPosition);
    on<EndPosition>(_onEndPosition);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(LoadUserWords(userId: state.user!.uid));
      }
    });
  }

  void _onLoadUserWords(LoadUserWords event, emit) async {
    List<WordNewModel> userWords = await _databaseRepository.getUserWords(event.userId).first;
    emit(WordLoaded(userWords: userWords));
  }

  void _onUpdateBox(UpdateBox event, emit) {
    if (state is WordLoaded) {
      final currentState = state as WordLoaded;
      emit(WordLoaded(userWords: currentState.userWords, boxIndex: event.boxIndex));
    }
  }

  void _onUpdateFrontSide(UpdateFrontSide event, emit) {
    if (state is WordLoaded) {
      final currentState = state as WordLoaded;
      emit(WordLoaded(
        userWords: currentState.userWords,
        isFrontSide: !currentState.isFrontSide,
      ));
    }
  }

  void _onDragPosition(DragPosition event, emit) {
    if (state is WordLoaded) {
      final currentState = state as WordLoaded;
      emit(WordLoaded(
        userWords: currentState.userWords,
        position: event.details.delta,
      ));
    }
  }

  void _onEndPosition(EndPosition event, emit) {
    if (state is WordLoaded) {
      final currentState = state as WordLoaded;
      emit(WordLoaded(
        userWords: currentState.userWords,
        position: Offset.zero,
      ));
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
