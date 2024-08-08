import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/user.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/user/base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final DatabaseRepository databaseRepository;

  UserRepository({
    required this.databaseRepository,
  });

  @override
  Stream<AppUserInfo?> userInfoStream(String userId) {
    return databaseRepository.documentStream(
      path: "users/$userId",
      builder: (data, _) => AppUserInfo.fromJson(data),
    );
  }

  @override
  Future<void> addInitialLevels(String userId) async {
    final List<LevelModel> levels = await databaseRepository.collectionToList(
      path: "levels",
      builder: (data, _) => LevelModel.fromJson(data),
    );

    final List<String> docIdList = levels.map((level) => level.id).toList();

    await databaseRepository.setBatchDataForDocInList(
      baseColPath: "users/$userId/levels",
      docIdList: docIdList,
      dataFromId: (docId) {
        final level = levels.firstWhere((word) => word.id == docId);
        return level.toJson();
      },
      merge: true,
    );
  }

  @override
  Future<void> addInitialLessons(String userId) async {
    final List<LessonModel> lessons = await databaseRepository
        .collectionStream(
            path: "lessons", builder: (data, _) => LessonModel.fromJson(data))
        .first;

    final List<String> docIdList = lessons.map((lesson) => lesson.id).toList();

    await databaseRepository.setBatchDataForDocInList(
      baseColPath: "users/$userId/lessons",
      docIdList: docIdList,
      dataFromId: (docId) {
        final lesson = lessons.firstWhere((lesson) => lesson.id == docId);
        return lesson.toJson();
      },
      merge: true,
    );
  }

  @override
  Future<void> addInitialWords(String userId) async {
    final List<WordModel> words = await databaseRepository
        .collectionStream(
            path: "words", builder: (data, _) => WordModel.fromJson(data))
        .first;

    final List<String> docIdList = words.map((word) => word.id).toList();

    await databaseRepository.setBatchDataForDocInList(
      baseColPath: "users/$userId/words",
      docIdList: docIdList,
      dataFromId: (docId) {
        final word = words.firstWhere((word) => word.id == docId);
        return word.toJson();
      },
      merge: true,
    );
  }
}
