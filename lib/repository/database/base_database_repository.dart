import 'package:flaapp/model/word_new.dart';

abstract class BaseDatabaseRepository {
  Stream<List<WordNewModel>> getUserWords(String userId, String level, String lesson);
  Future<void> swipeCard(String userId, WordNewModel word, bool swipeRight);
  Future<void> setUp(String userId);
}
