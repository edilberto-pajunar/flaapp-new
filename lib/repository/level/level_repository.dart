import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/level/base_level_repository.dart';
import 'package:flaapp/utils/constant/strings/constant.dart';

class LevelRepository extends BaseLevelRepository {
  final DatabaseRepository databaseRepository;

  LevelRepository({
    required this.databaseRepository,
  });

  @override
  Future<List<LevelModel>> getLevels() async {
    return await databaseRepository.collectionToList(
      path: "levels",
      queryBuilder: (query) => query.orderBy("order", descending: false),
      builder: (data, _) => LevelModel.fromJson(data),
    );
  }

  @override
  Stream<List<LevelModel>> getUserLevels(String userId) {
    return databaseRepository.collectionStream(
      path: "users/$userId/user_levels",
      queryBuilder: (query) => query.orderBy("label", descending: false),
      builder: (data, _) => LevelModel.fromJson(data),
    );
  }

  @override
  Stream<List<LevelModel>> getAdminLevels() {
    return databaseRepository.collectionStream(
      path: tLevelPath,
      queryBuilder: (query) => query.orderBy("label", descending: false),
      builder: (data, _) => LevelModel.fromJson(data),
    );
  }

  @override
  Future<void> adminAddLevel(String level) async {
    final int length = await databaseRepository.getCount(path: "levels");
    final id = length.toString().padLeft(4, "0");

    final LevelModel levelModel = LevelModel(
      label: level,
      id: id,
      locked: true,
    );

    await databaseRepository.setData(
      path: "$tLevelPath/$id",
      data: levelModel.toJson(),
      merge: true,
    );
  }

  @override
  Future<void> deleteAdminLevel(String level) async {
    await databaseRepository.deleteData(collection: "levels", doc: level);
  }

  @override
  Future<void> updateAdminLevel(LevelModel level) async {
    await databaseRepository.setData(
      path: "$tLevelPath/${level.id}",
      data: level.toJson(),
      merge: true,
    );
  }

  @override
  Future<void> addUserLevel({
    required String levelId,
    required String userId,
  }) async {
    final level = await databaseRepository.getData(
      path: "levels/$levelId",
      builder: (data, _) => LevelModel.fromJson(data),
    );

    if (level == null) {
      throw Exception("Level not found");
    }

    await databaseRepository.setData(
      path: "users/$userId/user_levels/$levelId",
      data: level.copyWith(locked: false).toJson(),
    );
  }

  @override
  Future<void> unlockUserLevel({
    required String userId,
    required String levelId,
  }) async {
    try {
      // Get all levels ordered by their order field
      final allLevels = await databaseRepository.collectionToList(
        path: "levels",
        queryBuilder: (query) => query.orderBy("order", descending: false),
        builder: (data, _) => LevelModel.fromJson(data),
      );

      // Find current level index
      final currentIndex = allLevels.indexWhere((level) => level.id == levelId);

      // If there's a next level, unlock it and add its first lesson
      if (currentIndex != -1 && currentIndex < allLevels.length - 1) {
        final nextLevel = allLevels[currentIndex + 1];

        // Add the next level to user's levels (unlocked)
        await databaseRepository.setData(
          path: "users/$userId/user_levels/${nextLevel.id}",
          data: nextLevel.copyWith(locked: false).toJson(),
        );

        // // Get the first lesson of the next level and add it to user_lessons
        // final nextLevelLessons = await databaseRepository.collectionToList(
        //   path: "levels/${nextLevel.id}/lessons",
        //   queryBuilder: (query) =>
        //       query.orderBy("order", descending: false).limit(1),
        //   builder: (data, _) => LessonModel.fromJson(data),
        // );

        // if (nextLevelLessons.isNotEmpty) {
        //   final firstLesson = nextLevelLessons.first;
        //   await databaseRepository.setData(
        //     path: "users/$userId/user_lessons/${firstLesson.id}",
        //     data: firstLesson
        //         .copyWith(locked: false, status: LessonStatus.inProgress)
        //         .toJson(),
        //   );
        //   print(
        //       "Next level unlocked: ${nextLevel.label}, first lesson added: ${firstLesson.label}");
        // }
      }
    } catch (e) {
      print("Error checking/unlocking next level: $e");
    }
  }
}
