part of 'translate_bloc.dart';

sealed class TranslateState extends Equatable {
  const TranslateState();

  @override
  List<Object> get props => [];
}

final class TranslateInitial extends TranslateState {}

final class TranslateLoading extends TranslateState {}

final class TranslateLoaded extends TranslateState {
  final List<String> translatedWordList;
  final bool isEdit;

  const TranslateLoaded({
    required this.translatedWordList,
    this.isEdit = false,
  });

  @override
  List<Object> get props => [translatedWordList, isEdit];

  TranslateLoaded copyWith({
    List<String>? translatedWordList,
    bool? isEdit,
  }) {
    return TranslateLoaded(
      translatedWordList: translatedWordList ?? this.translatedWordList,
      isEdit: isEdit ?? this.isEdit,
    );
  }
}
