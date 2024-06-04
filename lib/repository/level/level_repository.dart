import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/level/base_level_repository.dart';

class LevelRepository extends BaseLevelRepository {
  final DatabaseRepository databaseRepository;

  LevelRepository({
    required this.databaseRepository,
  });

  @override
  Stream<List<LevelModel>> getLevels(String userId) {
    return databaseRepository.collectionStream(
      path: "users/$userId/levels",
      queryBuilder: (query) => query.orderBy("label", descending: false),
      builder: (data, _) => LevelModel.fromJson(data),
    );
  }
}
