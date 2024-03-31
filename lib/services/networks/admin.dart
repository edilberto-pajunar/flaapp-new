import 'dart:convert';

import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/services/constant/strings/api.dart';
import 'package:flaapp/services/constant/strings/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Admin extends ChangeNotifier {
  static final List<String> levelList = [
    "A1",
    "A2",
    "B1",
    "B2",
  ];

  static final List<List<String>> lessonList = [
    [
      "Greetings",
      "Personal Information",
      "Numbers",
    ],
  ];

  String? level = "A1";

  void updateLevel(String? value) {
    level = value;
    notifyListeners();
  }

  String? lesson = "Greetings";

  void updateLesson(String? value) {
    lesson = value;
    notifyListeners();
  }

  static List<String> translationLangList = [
    "EN",
    "ES",
    "DE",
  ];

  String? translationLang = "EN";

  void updateTranslationLang(String? value) {
    translationLang = value;
    notifyListeners();
  }

  Future<LessonModel> getWordList() async {
    final String lessons = await rootBundle.loadString(tLessonJson);

    final jsonFile = jsonDecode(lessons);
    final Map<String, dynamic> data = (jsonFile["lessons"]
        as List)[lessonList[levelList.indexOf(level!)].indexOf(lesson!)];

    final LessonModel lessonModel = LessonModel.fromJson(data);

    return lessonModel;
  }

  Future<String> translateWord(
      String word, String targetLang, String sourceLang) async {
    final Uri uri = Uri.https(Api.baseUrl, "/v2/translate");
    final Map<String, dynamic> body = {
      "text": [
        word,
      ],
      "source_lang": sourceLang,
      "target_lang": targetLang,
    };

    print("Calling: $uri");

    try {
      final response =
          await http.post(uri, body: jsonEncode(body), headers: Api.headers);
      if (response.statusCode == 200) {
        print("Response: ${response.body}");
        return jsonDecode(response.body)["translations"][0]["text"];
      } else {
        return "";
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  String? enWord;

  void updateEnWordChange(String val) {
    enWord = val;
    notifyListeners();
  }

  String? deWord;

  void updateDeWordChange(String val) {
    deWord = val;
    notifyListeners();
  }

  String? esWord;

  void updateEsWordChange(String val) {
    esWord = val;
    notifyListeners();
  }

  Future<void> updateTranslateWord(String word, String sourceLang) async {
    Future.wait([
      translateWord(word, "EN", sourceLang),
      translateWord(word, "DE", sourceLang),
      translateWord(word, "ES", sourceLang),
    ]).then((value) {
      enWord = value[0];
      deWord = value[1];
      esWord = value[2];
      notifyListeners();
    });
  }

  bool isEdit = false;

  void updateIsEdit() {
    isEdit = !isEdit;
    notifyListeners();
  }
}
