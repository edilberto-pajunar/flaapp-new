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

class CardSwiped extends CardEvent {
  final String wordId;
  final CardSwiperDirection direction;
  final String userId;
  final int box;

  const CardSwiped({
    required this.wordId,
    required this.direction,
    required this.userId,
    required this.box,
  });
}

class CardProgressIndexChanged extends CardEvent {
  final int currentBox;

  const CardProgressIndexChanged({
    required this.currentBox,
  });
}
