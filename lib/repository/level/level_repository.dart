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
  Stream<List<LevelModel>> getLevels(
    String userId, {
    bool admin = false,
  }) {
    return databaseRepository.collectionStream(
      path: "users/$userId/levels",
      queryBuilder: (query) => query.orderBy("label", descending: false),
      builder: (data, _) => LevelModel.fromJson(data),
    );
  }

  @override
  Stream<List<LevelModel>> getAdminLevels() {
    return databaseRepository.collectionStream(
      path: tLevelPath,
      queryBuilder: (query) => query.orderBy("id", descending: false),
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
}
