import 'package:flaapp/model/level.dart';

abstract class BaseLevelRepository {
  Stream<List<LevelModel>> getLevels(String userId);
  Stream<List<LevelModel>> getAdminLevels();

  Future<void> adminAddLevel(String level);
  Future<void> deleteAdminLevel(String level);
}
