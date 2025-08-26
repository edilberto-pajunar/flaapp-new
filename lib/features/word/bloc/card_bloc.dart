import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final WordRepository _wordRepository;

  CardBloc({
    required WordRepository wordRepository,
  })  : _wordRepository = wordRepository,
        super(CardState()) {
    on<CardFlipped>(_onFlipped);
    on<CardSwipedDirectionChanged>(_onSwipedDirectionChanged);
    on<CardSwiped>(_onSwiped);
    on<CardProgressIndexChanged>(_onProgressIndexChanged);
  }

  void _onFlipped(CardFlipped event, Emitter<CardState> emit) {
    emit(state.copyWith(isFront: !state.isFront));
  }

  void _onSwipedDirectionChanged(
      CardSwipedDirectionChanged event, Emitter<CardState> emit) {
    emit(state.copyWith(direction: event.direction));
  }

  void _onSwiped(CardSwiped event, Emitter<CardState> emit) async {
    try {
      await _wordRepository.swipeCard(
        wordId: event.wordId,
        direction: event.direction,
        userId: event.userId,
        box: event.box,
      );
    } catch (e) {
      print("Error swiping card: $e");
    }
  }

  void _onProgressIndexChanged(
    CardProgressIndexChanged event,
    Emitter<CardState> emit,
  ) {
    emit(state.copyWith(currentProgressIndex: event.currentBox));
  }
}
