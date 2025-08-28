part of 'card_bloc.dart';

enum CardStateStatus {
  initial,
  loading,
  success,
  failed,
}

class CardState extends Equatable {
  final bool isFront;
  final CardSwiperDirection direction;
  final int currentProgressIndex;
  final CardStateStatus status;
  const CardState({
    this.isFront = true,
    this.direction = CardSwiperDirection.none,
    this.currentProgressIndex = 0,
    this.status = CardStateStatus.initial,
  });

  CardState copyWith({
    bool? isFront,
    CardSwiperDirection? direction,
    int? currentProgressIndex,
    CardStateStatus? status,
  }) {
    return CardState(
      isFront: isFront ?? this.isFront,
      direction: direction ?? this.direction,
      currentProgressIndex: currentProgressIndex ?? this.currentProgressIndex,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        isFront,
        direction,
        currentProgressIndex,
        status,
      ];
}
