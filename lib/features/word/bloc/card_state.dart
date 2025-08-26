part of 'card_bloc.dart';

class CardState extends Equatable {
  final bool isFront;
  final CardSwiperDirection direction;
  final int currentProgressIndex;

  const CardState({
    this.isFront = true,
    this.direction = CardSwiperDirection.none,
    this.currentProgressIndex = 0,
  });

  CardState copyWith({
    bool? isFront,
    CardSwiperDirection? direction,
    int? currentProgressIndex,
  }) {
    return CardState(
      isFront: isFront ?? this.isFront,
      direction: direction ?? this.direction,
      currentProgressIndex: currentProgressIndex ?? this.currentProgressIndex,
    );
  }

  @override
  List<Object> get props => [
        isFront,
        direction,
        currentProgressIndex,
      ];
}
