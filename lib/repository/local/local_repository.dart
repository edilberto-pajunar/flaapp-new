import 'dart:developer';

import 'package:flaapp/repository/local/base_local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository extends BaseLocalRepository {
  @override
  Future<String> getTime(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final time = preferences.getString(id);

    if (time != null) {
      return preferences.getString(id)!;
    } else {
      return "";
    }
  }

  @override
  Future<void> setTime(String id, int time) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String updatedTime = DateTime.now().add(Duration(minutes: time)).toIso8601String();

    await preferences.setString(id, updatedTime).then((value) {
      log("Time added!");
    });
  }

  @override
  Future<void> cancelTime(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(id);
  }
}
