import 'package:flaapp/model/level.dart';

abstract class BaseLevelRepository {
  Future<List<LevelModel>> getLevels();
  Stream<List<LevelModel>> getUserLevels(
    String userId,
  );
  Future<void> addUserLevel({
    required String levelId,
    required String userId,
  });

  // ADMIN
  Stream<List<LevelModel>> getAdminLevels();
  Future<void> adminAddLevel(String level);
  Future<void> deleteAdminLevel(String level);
  Future<void> updateAdminLevel(LevelModel level);
}
