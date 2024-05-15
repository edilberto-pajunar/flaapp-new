import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word_new.dart';

abstract class BaseDatabaseRepository {
  Stream<List<LevelModel>> getLevels(String? userId);
  Stream<List<LessonModel>> getLessons(String? userId, String level);
  Stream<List<WordNewModel>> getWords(String? userId, String level, String lesson);
  Future<void> setUp(User user);
  Future<void> swipeCard(String userId, WordNewModel word, bool swipeRight);
  Future<void> setLevel();
  Future<void> setLesson();
  Future<void> updateWords();
  Future<void> unlockLesson(String userId, LessonModel lesson, String level);

  Future<void> addLevel(LevelModel level);
  Future<void> addLesson(LessonModel lesson);
  Future<void> addWord(WordNewModel word);
}
