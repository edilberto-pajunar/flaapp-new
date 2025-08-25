import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/lesson/base_lesson_repository.dart';
import 'package:flaapp/utils/constant/strings/constant.dart';

class LessonRepository extends BaseLessonRepository {
  final DatabaseRepository databaseRepository;

  LessonRepository({
    required this.databaseRepository,
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
  Future<void> unlockLesson(String userId, LessonModel lesson) async {
    await databaseRepository.setData(
      path: "users/$userId/lessons/${lesson.id}",
      data: lesson.copyWith(locked: false).toJson(),
    );
  }

  @override
  Stream<List<LessonModel>> getAdminLessons(String level) {
    return databaseRepository.collectionStream(
      path: "lessons",
      queryBuilder: (query) => query.where("level.id", isEqualTo: level),
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
