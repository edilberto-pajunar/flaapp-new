part of 'card_bloc.dart';

class CardState extends Equatable {
  final bool isFront;

  const CardState({
    this.isFront = true,
  });

  CardState copyWith({
    bool? isFront,
  }) {
    return CardState(isFront: isFront ?? this.isFront);
  }

  @override
  List<Object> get props => [
        isFront,
      ];
}
