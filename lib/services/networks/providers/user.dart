import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/models/data.dart';
import 'package:flaapp/models/user.dart';
import 'package:flaapp/values/strings/constant.dart';
import 'package:flaapp/values/strings/json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserProvider extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool isLoading = false;

  void showHUD(bool value) {
    isLoading = value;
    notifyListeners();
  }
  
  Future<void> generateDatas() async {
    final String wordsJson = await rootBundle.loadString(JsonString.wordJson);
    final String updatedWordJson = await rootBundle.loadString(JsonString.updatedWordJson);
    final String lessonJson = await rootBundle.loadString(JsonString.lessonJson);
    final String levelJson = await rootBundle.loadString(JsonString.levelJson);
    final now = DateTime.now();

    _db.collection(tDataPath).doc(now.toIso8601String()).set({
      "dateCreated": FieldValue.serverTimestamp(),
      ...jsonDecode(updatedWordJson),
      ...jsonDecode(lessonJson),
      ...jsonDecode(levelJson),
    }).then((value) => debugPrint("Added words successfully!"));
  }

  static TextEditingController email = TextEditingController();
  static TextEditingController username = TextEditingController();
  static TextEditingController password = TextEditingController();


  /// [signup] get the [email] and [password] to signup
  /// from firebase
  Future<void> signup() async {
    showHUD(true);

    List<WordModel> wordModels = [];
    List<LevelModel> levelModels = [];
    List<LessonModel> lessonModels = [];

    await _db.collection(tDataPath).orderBy("dateCreated").limit(1).get().then((event) {
      final map = event.docs.first.data();
      wordModels = (map[tWordPath] as List).map((e) => WordModel.fromJson(e)).toList();
      levelModels = (map[tLevelPath] as List).map((e) => LevelModel.fromJson(e)).toList();
      lessonModels = (map[tLessonPath] as List).map((e) => LessonModel.fromJson(e)).toList();
    });

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: UserProvider.email.text,
      password: UserProvider.password.text,
    );

    final String id = userCredential.user!.uid;

    final UserModel userModel = UserModel(
      name: UserProvider.username.text,
      email: UserProvider.email.text,
      password: UserProvider.password.text,
    );

    await _db.collection(tUserPath).doc(id).set(
      {
        "user": userModel.toJson(),
        tDataPath: {
          tWordPath: (wordModels).map((e) => e.toJson()),
          tLevelPath: (levelModels).map((e) => e.toJson()),
          tLessonPath: (lessonModels).map((e) => e.toJson()),
        }
      }
    ).then((value){
      showHUD(false);
      return debugPrint("Add datas succesfully! $id");
    })
    .onError((error, stackTrace) => debugPrint("Something went wrong: $error"));
  
    notifyListeners();
  }

  String? id;

  /// [login] get the [email] and [password] to login
  /// from firebase
  Future<void> login() async {
    showHUD(true);

    await _auth.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    ).then((value) {
      id = value.user!.uid;
      showHUD(false);
    }).onError((error, stackTrace) {
      showHUD(false);
    });

    notifyListeners();
  }

  Stream<DataModel>? dataStream;

  Stream<DataModel> getDataStream(String id) {
    return _db.collection(tUserPath).doc(id).snapshots().map((event) {
      final map = event.data()!["data"];

      return DataModel.fromJson(map);
    });
  }

  void updateDataStream({
    required String id,
  }) {
    dataStream = getDataStream(id);
    notifyListeners();
  }

  Stream<UserModel>? userStream;

  Stream<UserModel> getUserStream(String id) {
    return _db.collection(tUserPath).doc(id).snapshots().map((event) {
      final map = event.data()!["user"];

      return UserModel.fromJson(map);
    });
  }

  void updateUserStream({
    required String id,
  }) {
    userStream = getUserStream(id);
    notifyListeners();
  }

  /// [clearForm] clears the form once it logged in
  void clearForm() {
    username.clear();
    email.clear();
    password.clear();
    notifyListeners();
  }

}