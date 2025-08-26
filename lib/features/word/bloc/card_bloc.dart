import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState()) {
    on<CardFlipped>(_onFlipped);
    on<CardSwipedDirectionChanged>(_onSwipedDirectionChanged);
  }

  void _onFlipped(CardFlipped event, Emitter<CardState> emit) {
    emit(state.copyWith(isFront: !state.isFront));
  }

  void _onSwipedDirectionChanged(
      CardSwipedDirectionChanged event, Emitter<CardState> emit) {
    emit(state.copyWith(direction: event.direction));
  }
}
