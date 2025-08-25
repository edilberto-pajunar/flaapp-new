import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState()) {
    on<CardFlipped>(_onFlipped);
  }

  void _onFlipped(CardFlipped event, Emitter<CardState> emit) {
    emit(state.copyWith(isFront: !state.isFront));
  }
}
