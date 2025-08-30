import 'package:flaapp/model/language.dart';

abstract class BaseLanguageRepository {
  Stream<List<LanguageModel>> getLanguages();
}
