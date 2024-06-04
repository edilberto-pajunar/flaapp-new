import 'package:flaapp/model/lesson.dart';

abstract class BaseLessonRepository {
  Stream<List<LessonModel>> getLessons(String userId, String level);
}
