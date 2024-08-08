import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/lesson/base_lesson_repository.dart';

class LessonRepository extends BaseLessonRepository {
  final DatabaseRepository databaseRepository;

  LessonRepository({
    required this.databaseRepository,
  });

  @override
  Stream<List<LessonModel>> getLessons(String userId, String level) {
    return databaseRepository.collectionStream(
      path: "users/$userId/lessons",
      queryBuilder: (query) => query.where("level", isEqualTo: level),
      builder: (data, _) => LessonModel.fromJson(data),
    );
  }

  @override
  Future<void> unlockLesson(String userId, LessonModel lesson) async {
    await databaseRepository.setData(
      path: "users/$userId/lessons/${lesson.label}",
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
      level: level,
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
}
