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
}
