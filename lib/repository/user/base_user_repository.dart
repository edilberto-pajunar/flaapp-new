import 'package:flaapp/model/user.dart';

abstract class BaseUserRepository {
  Stream<AppUserInfo?> userInfoStream(String userId);
  Future<void> addInitialLevels(String userId);
  Future<void> addInitialLessons(String userId);
  Future<void> addInitialWords(String userId);
}
