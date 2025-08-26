part of 'card_bloc.dart';

class CardState extends Equatable {
  final bool isFront;
  final CardSwiperDirection direction;

  const CardState({
    this.isFront = true,
    this.direction = CardSwiperDirection.none,
  });

  CardState copyWith({
    bool? isFront,
    CardSwiperDirection? direction,
  }) {
    return CardState(
      isFront: isFront ?? this.isFront,
      direction: direction ?? this.direction,
    );
  }

  @override
  List<Object> get props => [
        isFront,
        direction,
      ];
}
