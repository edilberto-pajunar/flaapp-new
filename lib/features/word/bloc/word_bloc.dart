import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordRepository _wordRepository;
  StreamSubscription<int?>? timer;

  WordBloc({
    required WordRepository wordRepository,
    required LessonRepository lessonRepository,
  })  : _wordRepository = wordRepository,
        super(const WordState()) {
    on<WordInitRequested>(_onInitRequested);
    on<WordAddUserWordRequested>(_onAddUserWordRequested);
    on<WordFlipCardTapped>(_onFlipCardTapped);
    on<WordCardUpdateDragged>(_onCardUpdateDragged);
    on<WordCardEndDragged>(_onCardEndDragged);
    on<WordBoxTapped>(_onBoxTapped);
    on<WordLockedCardTriggered>(_onLockedCardTriggered);
    on<WordTimerInitRequested>(_onTimerInitRequested);
    on<WordCompleteTriggered>(_onCompleteTriggered);
    on<WordFailedTriggered>(_onFailedTriggered);
    on<WordSpeakRequested>(_onSpeakRequested);
  }

  void _onInitRequested(
    WordInitRequested event,
    Emitter<WordState> emit,
  ) async {
    emit(state.copyWith(
      wordLoadingStatus: WordLoadingStatus.loading,
    ));

    final List<WordModel> words = await _wordRepository.getWords(
      levelId: event.levelId,
      lessonId: event.lessonId,
    );
    emit(state.copyWith(words: words));

    try {
      await emit.forEach(
        _wordRepository.getUserWords(
          levelId: event.levelId,
          lessonId: event.lessonId,
          userId: event.user.uid,
        ),
        onData: (userWords) {
          if (userWords.isEmpty) {
            add(WordAddUserWordRequested(
              user: event.user,
              levelId: event.levelId,
              lessonId: event.lessonId,
            ));
          }

          return state.copyWith(
            words: userWords,
            wordLoadingStatus: WordLoadingStatus.success,
          );
          // final DateTime now = DateTime.now();
          // final currentMin = words.reduce((currentMin, word) =>
          //     word.box < currentMin.box ? word : currentMin);

          // if (words[0].lockedTime != null &&
          //     words[0].lockedTime!.isAfter(now)) {
          //   return state.copyWith(
          //     words: words,
          //     boxIndex: currentMin.box,
          //     lockedStatus: LockedStatus.locked,
          //   );
          // } else {
          //   return state.copyWith(
          //     words: words,
          //     boxIndex: currentMin.box,
          //     wordLoadingStatus: WordLoadingStatus.success,
          //     lockedStatus: LockedStatus.unlocked,
          //     lockedTime: null,
          //   );
          // }
        },
      );
    } catch (e) {
      add(WordFailedTriggered(
        error: "Word failed to load: $e",
      ));
    }
  }

  void _onAddUserWordRequested(
    WordAddUserWordRequested event,
    Emitter<WordState> emit,
  ) async {
    await _wordRepository.addUserWord(
      userId: event.user.uid,
      levelId: event.levelId,
      lessonId: event.lessonId,
    );
  }

  void _onFlipCardTapped(
    WordFlipCardTapped event,
    Emitter<WordState> emit,
  ) {
    emit(state.copyWith(
      frontVisible: !state.frontVisible,
    ));
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
          add(const WordLockedCardTriggered());
        }

        if (currentWords.length == 1 && event.word.box == 3) {
          add(WordCompleteTriggered());
        }

        // await _wordRepository.swipeCard(
        //   word: event.word,
        //   swipedRight: true,
        //   userId: _currentUser.uid,
        // );
      } else if (event.details.offset.dx < -100 || event.word.box == 4) {
        // await _wordRepository.swipeCard(
        //   word: event.word,
        //   swipedRight: false,
        //   userId: _currentUser.uid,
        // );
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

    emit(state.copyWith(wordLoadingStatus: WordLoadingStatus.loading));

    try {
      // await _wordRepository.lockCard(
      //   word: currentWords[0],
      //   userId: _currentUser.uid,
      // );

      emit(state.copyWith(
        lockedStatus: LockedStatus.locked,
        wordLoadingStatus: WordLoadingStatus.success,
      ));
    } catch (e) {
      add(WordFailedTriggered(error: "Failed to locked the card. $e"));
    }
  }

  void _onTimerInitRequested(
    WordTimerInitRequested event,
    Emitter<WordState> emit,
  ) async {
    // await emit.forEach(
    //   _wordRepository.lockCardStream(
    //     userId: _currentUser.uid,
    //     word: state.words[0],
    //   ),
    //   onData: (remainingSecond) {
    //     if (remainingSecond != null && remainingSecond > 0) {
    //       return state.copyWith(
    //         lockedTime: remainingSecond,
    //         lockedStatus: LockedStatus.locked,
    //         wordLoadingStatus: WordLoadingStatus.success,
    //       );
    //     } else if (remainingSecond == 0) {
    //       return state.copyWith(
    //         lockedTime: null,
    //         lockedStatus: LockedStatus.unlocked,
    //         wordLoadingStatus: WordLoadingStatus.success,
    //       );
    //     }

    //     return state.copyWith(
    //       lockedTime: null,
    //       lockedStatus: LockedStatus.unlocked,
    //       wordLoadingStatus: WordLoadingStatus.success,
    //     );
    //   },
    // );
  }

  void _onCompleteTriggered(
    WordCompleteTriggered event,
    Emitter<WordState> emit,
  ) {
    emit(state.copyWith(
      completeStatus: CompleteStatus.finished,
    ));
  }

  void _onFailedTriggered(
    WordFailedTriggered event,
    Emitter<WordState> emit,
  ) {
    emit(state.copyWith(
      wordLoadingStatus: WordLoadingStatus.failed,
      error: event.error,
    ));
  }

  FutureOr<void> _onSpeakRequested(
    WordSpeakRequested event,
    Emitter<WordState> emit,
  ) async {
    final FlutterTts flutterTts = FlutterTts();

    // 16 : us
    // 40 : de
    // 46 : es
    final List languages = await flutterTts.getLanguages;

    try {
      final isAvailable = await flutterTts.isLanguageAvailable("de");
      if (isAvailable) {
        await flutterTts.setLanguage(languages[16]);
        await flutterTts.speak(
          state.frontVisible ? event.frontWord : event.backWord,
        );
      }
      emit(state.copyWith(wordLoadingStatus: WordLoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        wordLoadingStatus: WordLoadingStatus.failed,
      ));
    }
  }
}
