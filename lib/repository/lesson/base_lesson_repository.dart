import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';

abstract class BaseLessonRepository {
  Future<List<LessonModel>> getLessons(String levelId);
  Stream<List<LessonModel>> getUserLessons({
    required String level,
  });
  Future<void> addUserLesson({
    required String levelId,
    required String lessonId,
  });
  Future<void> unlockUserLesson({
    required String levelId,
    required String currentLessonId,
  });

  // ADMIN SIDE
  Stream<List<LessonModel>> getAdminLessons(String levelId);
  Future<void> adminAddLesson(
      String levelId, String lesson, String description);
  Future<void> unlockLesson(LessonModel lesson);
  Future<void> deleteAdminLesson(String lesson);
  Future<void> updateAdminLesson(LessonModel lesson);
}
