import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';

abstract class BaseLessonRepository {
  Future<List<LessonModel>> getLessons(String levelId);
  Stream<List<LessonModel>> getUserLessons({
    required String userId,
    required String level,
  });
  Future<void> addUserLesson({
    required String userId,
    required String levelId,
    required String lessonId,
  });
  Future<void> unlockUserLesson({
    required String userId,
    required String levelId,
    required String currentLessonId,
  });

  // ADMIN SIDE
  Stream<List<LessonModel>> getAdminLessons(String level);
  Future<void> adminAddLesson(LevelModel level, String lesson);
  Future<void> unlockLesson(String userId, LessonModel lesson);
  Future<void> deleteAdminLesson(String lesson);
  Future<void> updateAdminLesson(LessonModel lesson);
}
