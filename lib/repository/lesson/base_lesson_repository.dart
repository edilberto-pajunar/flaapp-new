import 'package:flaapp/model/lesson.dart';

abstract class BaseLessonRepository {
  Stream<List<LessonModel>> getLessons(String userId, String level);
  Stream<List<LessonModel>> getAdminLessons(String level);
  Future<void> adminAddLesson(String level, String lesson);
  Future<void> unlockLesson(String userId, LessonModel lesson);
}
