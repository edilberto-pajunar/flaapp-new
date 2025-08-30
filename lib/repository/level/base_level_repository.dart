import 'package:flaapp/model/level.dart';

abstract class BaseLevelRepository {
  Future<List<LevelModel>> getLevels();
  Stream<List<LevelModel>> getUserLevels();
  Future<void> addUserLevel({
    required String levelId,
  });
  Future<void> unlockUserLevel({
    required String levelId,
  });

  // ADMIN
  Stream<List<LevelModel>> getAdminLevels();
  Future<void> adminAddLevel(String level);
  Future<void> deleteAdminLevel(String level);
  Future<void> updateAdminLevel(LevelModel level);
}
