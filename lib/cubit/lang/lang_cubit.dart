import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());

  void updateLanguage(String lang) {
    LangType newLangType;
    switch (lang) {
      case "en":
        newLangType = LangType.en;
        break;
      case "de":
        newLangType = LangType.de;
        break;
      case "es":
        newLangType = LangType.es;
        break;
      default:
        newLangType = LangType.en; // Default to English if the language is not supported
        break;
    }
    emit(LangState(langType: newLangType));
  }
}
