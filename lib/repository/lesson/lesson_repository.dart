import 'package:flaapp/model/lesson.dart';
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
    print("Lesson: ${lesson.toJson()}");

    await databaseRepository.setData(
      path: "users/$userId/lessons/${lesson.label}",
      data: lesson.copyWith(locked: false).toJson(),
    );
  }

  @override
  Stream<List<LessonModel>> getAdminLessons(String level) {
    return databaseRepository.collectionStream(
      path: "lessons",
      queryBuilder: (query) => query.where("level", isEqualTo: level),
      builder: (data, _) => LessonModel.fromJson(data),
    );
  }

  @override
  Future<void> adminAddLesson(String level, String lesson) async {
    final LessonModel lessonModel = LessonModel(
      label: lesson,
      level: level,
      id: lesson,
      locked: true,
    );

    await databaseRepository.setData(
      path: "lessons",
      data: lessonModel.toJson(),
    );
  }
}
