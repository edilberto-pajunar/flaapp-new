import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/local/local_repository.dart';
import 'package:flutter/gestures.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final DatabaseRepository _databaseRepository;
  final LocalRepository _localRepository;
  final AuthBloc _authBloc;
  final String level;
  final String lesson;
  StreamSubscription? _wordSubscription;
  StreamSubscription? _timeSubscription;

  WordBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
    required LocalRepository localRepository,
    required this.level,
    required this.lesson,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        _localRepository = localRepository,
        super(WordLoading()) {
    on<LoadUserWords>(_onLoadUserWords);
    on<UpdateHome>(_onUpdateHome);
    on<UpdateBox>(_onUpdateBox);
    on<UpdateFrontSide>(_onUpdateFrontSide);
    on<DragPosition>(_onDragPosition);
    on<SwipeCard>(_onSwipeCard);

    _wordSubscription = _databaseRepository
        .getWords(_authBloc.state.user!.uid, level, lesson)
        .listen((wordList) {
      add(LoadUserWords(
        userId: _authBloc.state.user!.uid,
        level: level,
        lesson: lesson,
        wordList: wordList,
      ));
    });
  }

  void _onLoadUserWords(LoadUserWords event, emit) async {
    final String id = "${event.level}-${event.lesson}";

    await _localRepository.getTime(id).then((time) {
      if (time.isNotEmpty) {
        final parsedTime = DateTime.tryParse(time)!;

        _timeSubscription =
            Stream.periodic(const Duration(seconds: 1), (timer) {
          return DateTime.now();
        }).listen((now) async {
          final difference = parsedTime.difference(now);

          if (parsedTime.isAfter(now)) {
            add(UpdateHome(
                wordList: event.wordList,
                duration:
                    '${difference.inHours}:${difference.inMinutes % 60}:${difference.inSeconds % 60}'));
          } else {
            add(UpdateHome(
              wordList: event.wordList,
            ));

            await _localRepository.cancelTime(id);
          }
        });
      } else {
        add(UpdateHome(
          wordList: event.wordList,
        ));

        _timeSubscription?.cancel();
      }
    });
  }

  void _onUpdateHome(UpdateHome event, emit) async {
    emit(
      WordLoaded(
        userWords: event.wordList,
        boxIndex: state is WordLoading
            ? event.wordList.first.box
            : (state as WordLoaded).boxIndex,
        duration: event.duration,
        position: 0,
        isFrontSide:
            state is WordLoading ? true : (state as WordLoaded).isFrontSide,
      ),
    );
  }

  void _onUpdateBox(UpdateBox event, emit) {
    if (state is WordLoaded) {
      final currentState = state as WordLoaded;
      emit(WordLoaded(
        userWords: currentState.userWords,
        boxIndex: event.boxIndex,
      ));
    }
  }

  void _onUpdateFrontSide(UpdateFrontSide event, emit) {
    if (state is WordLoaded) {
      final currentState = state as WordLoaded;
      emit(WordLoaded(
        userWords: currentState.userWords,
        isFrontSide: !currentState.isFrontSide,
        boxIndex: currentState.boxIndex,
      ));
    }
  }

  void _onDragPosition(DragPosition event, emit) {
    if (state is WordLoaded) {
      final currentState = state as WordLoaded;
      emit(WordLoaded(
        userWords: currentState.userWords,
        position: event.details.localPosition.dx,
        boxIndex: currentState.boxIndex,
      ));
    }
  }

  void _onSwipeCard(SwipeCard event, emit) async {
    final state = this.state as WordLoaded;
    final String id = _authBloc.state.user!.uid;
    int time = 0;

    if (event.wordList.length == 1 && state.boxIndex != 4) {
      emit(WordLoading());
      await _databaseRepository.swipeCard(
          id, event.currentWord, event.swipeRight);

      if (event.currentWord.box == 0) {
        time = 1;
      } else if (event.currentWord.box == 1) {
        time = 2;
      } else if (event.currentWord.box == 2) {
        time = 3;
      } else if (event.currentWord.box == 3) {
        time = 4;
      }

      await _localRepository.setTime(
          "${event.currentWord.level}-${event.currentWord.lesson}", time);

      await _databaseRepository.getWords(id, level, lesson).first.then((value) {
        add(LoadUserWords(
            wordList: value, userId: id, level: level, lesson: lesson));
      });
    } else {
      await _databaseRepository.swipeCard(
          _authBloc.state.user!.uid, event.currentWord, event.swipeRight);
    }

    if (event.wordList.length == 1 && state.boxIndex == 3) {
      await _databaseRepository.unlockLesson(
        id,
        event.lesson,
        event.currentWord.level.id,
      );
      emit(WordComplete());
    }
  }

  @override
  Future<void> close() async {
    _timeSubscription?.cancel();
    _wordSubscription?.cancel();
    super.close();
  }
}
