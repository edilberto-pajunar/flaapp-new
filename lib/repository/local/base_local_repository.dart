abstract class BaseLocalRepository {
  Future<void> setTime(String id, int time);
  Future<String> getTime(String id);
  Future<void> cancelTime(String id);
}
