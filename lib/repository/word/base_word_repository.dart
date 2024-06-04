import 'package:flaapp/model/word_new.dart';

abstract class BaseWordRepository {
  Stream<List<WordModel>> getWords({
    required String userId,
    required String level,
    required String lesson,
  });
}
