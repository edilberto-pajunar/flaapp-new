part of 'translate_bloc.dart';

sealed class TranslateState extends Equatable {
  const TranslateState();

  @override
  List<Object> get props => [];
}

final class TranslateInitial extends TranslateState {}

final class TranslateLoading extends TranslateState {}

final class TranslateLoaded extends TranslateState {}
