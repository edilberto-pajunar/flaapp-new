import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word_new.dart';

abstract class BaseDatabaseRepository {
  Stream<List<WordNewModel>> getAdminWords(String level, String lesson);
  Stream<List<LevelModel>> getLevels();
  Stream<List<LevelModel>> getUserLevels(String userId);
  Stream<List<LessonModel>> getLessons(String level);
  Stream<List<LessonModel>> getUserLessons(String userId);
  Stream<List<WordNewModel>> getUserWords(String userId, String level, String lesson);
  Future<void> swipeCard(String userId, WordNewModel word, bool swipeRight);
  Future<void> setUp(String userId);
  Future<void> updateWords();
  Future<void> updateLevel();
  Future<void> updateLesson();
  Future<void> unlockLesson(String userId, String lesson);
}
