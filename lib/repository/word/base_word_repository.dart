import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word.dart';

abstract class BaseWordRepository {
  Future<List<WordModel>> getWords({
    required String levelId,
    required String lessonId,
  });

  Stream<List<WordModel>> getUserWords({
    required String userId,
    required String levelId,
    required String lessonId,
  });

  Future<void> addUserWord({
    required String userId,
    required String levelId,
    required String lessonId,
  });

  // ADMIN SIDE
  Stream<List<WordModel>> getAdminWords({
    required String level,
    required String lesson,
  });

  Future<void> adminAddWord({
    required LevelModel level,
    required LessonModel lesson,
    required String us,
    required String de,
    required String es,
  });

  Future<void> swipeCard({
    required WordModel word,
    required bool swipedRight,
    required String userId,
  });

  Future<void> lockCard({
    required WordModel word,
    required String userId,
  });

  Future<void> unLockCard({
    required WordModel word,
    required String userId,
  });

  Stream<int?> lockCardStream({
    required WordModel word,
    required String userId,
  });

  Future<void> deleteWordLesson(String word);

  Future<void> updateAdminWord(WordModel word);
}
