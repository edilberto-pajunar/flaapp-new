import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/lesson/base_lesson_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flaapp/utils/constant/strings/constant.dart';

class LessonRepository extends BaseLessonRepository {
  final DatabaseRepository databaseRepository;
  final LevelRepository levelRepository;

  LessonRepository({
    required this.databaseRepository,
    required this.levelRepository,
  });

  @override
  Future<List<LessonModel>> getLessons(String levelId) async {
    return await databaseRepository.collectionToList(
      path: "levels/$levelId/lessons",
      queryBuilder: (query) => query.orderBy("order", descending: false),
      builder: (data, _) => LessonModel.fromJson(data),
    );
  }

  @override
  Stream<List<LessonModel>> getUserLessons({
    required String userId,
    required String level,
  }) {
    return databaseRepository.collectionStream(
      path: "users/$userId/user_lessons",
      builder: (data, _) => LessonModel.fromJson(data),
    );
  }

  @override
  Future<void> addUserLesson({
    required String userId,
    required String levelId,
    required String lessonId,
  }) async {
    final LessonModel? lesson = await databaseRepository.getData(
      path: "levels/$levelId/lessons/$lessonId",
      builder: (data, _) => LessonModel.fromJson(data),
    );

    if (lesson == null) {
      throw Exception("Lesson not found");
    }

    await databaseRepository.setData(
      path: "users/$userId/user_lessons/${lesson.id}",
      data: lesson
          .copyWith(locked: false, status: LessonStatus.inProgress)
          .toJson(),
    );
  }

  @override
  Future<void> unlockUserLesson({
    required String userId,
    required String levelId,
    required String currentLessonId,
  }) async {
    try {
      // Get all lessons in the current level, ordered by order field
      final lessons = await databaseRepository.collectionToList(
        path: "levels/$levelId/lessons",
        queryBuilder: (query) => query.orderBy("order", descending: false),
        builder: (data, _) => LessonModel.fromJson(data),
      );

      // Find current lesson index
      final currentIndex =
          lessons.indexWhere((lesson) => lesson.id == currentLessonId);

      // If there's a next lesson in the same level, add it to user_lessons
      if (currentIndex != -1 && currentIndex < lessons.length - 1) {
        final LessonModel nextLesson = lessons[currentIndex + 1];

        // Add the next lesson to user's lessons (unlocked and in progress)
        await databaseRepository.setData(
          path: "users/$userId/user_lessons/${nextLesson.id}",
          data: nextLesson
              .copyWith(locked: false, status: LessonStatus.inProgress)
              .toJson(),
        );

        print("Next lesson added: ${nextLesson.label}");
      } else {
        // If no more lessons in current level, check if we should unlock next level
        await levelRepository.unlockUserLevel(userId: userId, levelId: levelId);
      }
    } catch (e) {
      print("Error adding next lesson: $e");
    }
  }

  @override
  Future<void> unlockLesson(String userId, LessonModel lesson) async {
    await databaseRepository.setData(
      path: "users/$userId/lessons/${lesson.id}",
      data: lesson.copyWith(locked: false).toJson(),
    );
  }

  @override
  Stream<List<LessonModel>> getAdminLessons(String levelId) {
    return databaseRepository.collectionStream(
      path: "levels/$levelId/lessons",
      queryBuilder: (query) => query.orderBy("order", descending: false),
      builder: (data, _) => LessonModel.fromJson(data),
    );
  }

  @override
  Future<void> adminAddLesson(LevelModel level, String lesson) async {
    final int length = await databaseRepository.getCount(path: "lessons");
    final id = length.toString().padLeft(4, "0");

    final LessonModel lessonModel = LessonModel(
      label: lesson,
      levelId: level.id,
      id: id,
      locked: true,
    );

    await databaseRepository.setData(
      path: "lessons/$id",
      data: lessonModel.toJson(),
    );
  }

  @override
  Future<void> deleteAdminLesson(String lesson) async {
    await databaseRepository.deleteData(collection: "lessons", doc: lesson);
  }

  @override
  Future<void> updateAdminLesson(LessonModel lesson) async {
    await databaseRepository.setData(
      path: "$tLessonPath/${lesson.id}",
      data: lesson.toJson(),
      merge: true,
    );
  }
}
