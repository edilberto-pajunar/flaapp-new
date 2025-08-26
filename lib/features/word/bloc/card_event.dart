part of 'card_bloc.dart';

class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class CardFlipped extends CardEvent {}

class CardSwipedDirectionChanged extends CardEvent {
  final CardSwiperDirection direction;

  const CardSwipedDirectionChanged({
    required this.direction,
  });
}
