import 'package:flaapp/model/language.dart';

abstract class BaseLanguageRepository {
  Stream<List<LanguageModel>> getLanguages();
  Future<void> changeLanguage(LanguageModel language);
}
