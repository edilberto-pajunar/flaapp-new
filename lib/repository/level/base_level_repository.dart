import 'package:flaapp/model/level.dart';

abstract class BaseLevelRepository {
  Stream<List<LevelModel>> getLevels(String userId);
}
