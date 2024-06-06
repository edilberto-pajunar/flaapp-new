import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordRepository _wordRepository;

  WordBloc({
    required WordRepository wordRepository,
    required LessonRepository lessonRepository,
  })  : _wordRepository = wordRepository,
        super(const WordState()) {
    on<WordInitRequested>(_onInitRequested);
    on<WordFlipCardTapped>(_onFlipCardTapped);
    on<WordCardUpdateDragged>(_onCardUpdateDragged);
    on<WordCardEndDragged>(_onCardEndDragged);
    on<WordBoxTapped>(_onBoxTapped);
    on<WordLockedCardTriggered>(_onLockedCardTriggered);
    on<WordTimerInitRequested>(_onTimerInitRequested);
    on<WordCompleteTriggered>(_onCompleteTriggered);
  }

  void _onInitRequested(
    WordInitRequested event,
    Emitter<WordState> emit,
  ) async {
    await emit.forEach(
      _wordRepository.getWords(
        userId: event.user.uid,
        level: event.level,
        lesson: event.lesson,
      ),
      onData: (words) {
        final currentMin = words.reduce((currentMin, word) =>
            word.box < currentMin.box ? word : currentMin);

        add(WordTimerInitRequested(user: event.user));
        return state.copyWith(words: words, boxIndex: currentMin.box);
      },
    );
  }

  void _onFlipCardTapped(
    WordFlipCardTapped event,
    Emitter<WordState> emit,
  ) {
    emit(state.copyWith(frontVisible: !state.frontVisible));
  }

  void _onCardUpdateDragged(
    WordCardUpdateDragged event,
    Emitter<WordState> emit,
  ) {
    emit(state.copyWith(
      position: event.details.localPosition.dx,
    ));
  }

  void _onCardEndDragged(
    WordCardEndDragged event,
    Emitter<WordState> emit,
  ) async {
    emit(state.copyWith(
      position: 0.0,
      swipeStatus: SwipeStatus.loading,
    ));

    final currentWords =
        state.words.where((word) => word.box == state.boxIndex).toList();

    try {
      if (event.details.offset.dx > 100 && event.word.box != 4) {
        if (currentWords.length == 1) {
          add(WordBoxTapped(boxIndex: state.boxIndex + 1));
          add(WordLockedCardTriggered(user: event.user));
        }

        if (currentWords.length == 1 && event.word.box == 3) {
          add(WordCompleteTriggered());
        }

        await _wordRepository.swipeCard(
          word: event.word,
          swipedRight: true,
          userId: event.user.uid,
        );
      } else if (event.details.offset.dx < -100 || event.word.box == 4) {
        await _wordRepository.swipeCard(
          word: event.word,
          swipedRight: false,
          userId: event.user.uid,
        );
      }

      emit(state.copyWith(
        swipeStatus: SwipeStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        swipeStatus: SwipeStatus.failed,
      ));
    }
  }

  void _onBoxTapped(
    WordBoxTapped event,
    Emitter<WordState> emit,
  ) async {
    emit(state.copyWith(boxIndex: event.boxIndex));
  }

  void _onLockedCardTriggered(
    WordLockedCardTriggered event,
    Emitter<WordState> emit,
  ) async {
    final currentWords =
        state.words.where((word) => word.box == state.boxIndex).toList();

    try {
      await _wordRepository.lockCard(
        word: currentWords[0],
        userId: event.user.uid,
      );
    } catch (e) {}
  }

  void _onTimerInitRequested(
    WordTimerInitRequested event,
    Emitter<WordState> emit,
  ) async {
    await emit.forEach(
      _wordRepository.lockCardStream(
        word: state.words[0],
        userId: event.user.uid,
      ),
      onData: (second) {
        if (second != 0) {
          return state.copyWith(
              lockedTime: second, lockedStatus: LockedStatus.locked);
        } else {
          return state.copyWith(
              lockedTime: null, lockedStatus: LockedStatus.unlocked);
        }
      },
    );
  }

  void _onCompleteTriggered(
    WordCompleteTriggered event,
    Emitter<WordState> emit,
  ) {
    emit(state.copyWith(completeStatus: CompleteStatus.finished));
  }
}
