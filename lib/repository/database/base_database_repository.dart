import 'package:flaapp/model/word_new.dart';

abstract class BaseDatabaseRepository {
  Stream<List<WordNewModel>> getUserWords(String userId);

}