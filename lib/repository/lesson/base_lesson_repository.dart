import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';

abstract class BaseLessonRepository {
  Stream<List<LessonModel>> getLessons(String userId, String level);
  Stream<List<LessonModel>> getAdminLessons(String level);
  Future<void> adminAddLesson(LevelModel level, String lesson);
  Future<void> unlockLesson(String userId, LessonModel lesson);
  Future<void> deleteAdminLesson(String lesson);
  Future<void> updateAdminLesson(LessonModel lesson);
}
