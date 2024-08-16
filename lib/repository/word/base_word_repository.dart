import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/translation.dart';
import 'package:flaapp/model/word.dart';

abstract class BaseWordRepository {
  Stream<List<WordModel>> getWords({
    required String userId,
    required String level,
    required String lesson,
  });

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
