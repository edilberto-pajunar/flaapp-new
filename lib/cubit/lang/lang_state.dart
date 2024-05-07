part of 'lang_cubit.dart';

enum LangType { en, de, es }

class LangState extends Equatable {
  final LangType langType;

  const LangState({
    this.langType = LangType.en,
  });

  @override
  List<Object> get props => [langType];
}

class LangInitial extends LangState {}
