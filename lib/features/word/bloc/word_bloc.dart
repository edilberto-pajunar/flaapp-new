import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/repository/word/word_repository.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordRepository _wordRepository;

  WordBloc({
    required WordRepository wordRepository,
  })  : _wordRepository = wordRepository,
        super(WordInitial()) {
    on<WordInitRequested>(_onInitRequested);
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
        onData: (words) => state.copyWith(words: words));
  }
}
