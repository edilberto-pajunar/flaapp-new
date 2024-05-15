import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/repository/database/base_database_repository.dart';
import 'package:flaapp/values/constant/strings/constant.dart';
import 'package:uuid/uuid.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<LevelModel>> getLevels(String? userId) {
    if (userId == null) {
      return _firebaseFirestore.collection(tLevelPath).orderBy("label").snapshots().map((snap) {
        return snap.docs.map((doc) => LevelModel.fromJson(doc.data())).toList();
      });
    } else {
      return _firebaseFirestore
          .collection(tUserPath)
          .doc(userId)
          .collection(tLevelPath)
          .orderBy("label")
          .snapshots()
          .map((event) {
        return event.docs.map((doc) => LevelModel.fromJson(doc.data())).toList();
      });
    }
  }

  @override
  Stream<List<LessonModel>> getLessons(String? userId, String? level) {
    if (userId == null) {
      return _firebaseFirestore.collection(tLessonPath).where("level", isEqualTo: level).snapshots().map((snap) {
        return snap.docs.map((doc) => LessonModel.fromJson(doc.data())).toList();
      });
    } else {
      return _firebaseFirestore
          .collection(tUserPath)
          .doc(userId)
          .collection(tLessonPath)
          .where("level", isEqualTo: level)
          .snapshots()
          .map((snap) {
        return snap.docs.map((doc) => LessonModel.fromJson(doc.data())).toList();
      });
    }
  }

  @override
  Stream<List<WordNewModel>> getWords(String? userId, String level, String lesson) {
    if (userId == null) {
      return _firebaseFirestore
          .collection(tWordPath)
          .where("level", isEqualTo: level)
          .where("lesson", isEqualTo: lesson)
          .orderBy("updateTime", descending: false)
          .snapshots()
          .map((snap) => snap.docs.map((doc) => WordNewModel.fromJson(doc.data())).toList());
    } else {
      return _firebaseFirestore
          .collection(tUserPath)
          .doc(userId)
          .collection(tWordPath)
          .where("level", isEqualTo: level)
          .where("lesson", isEqualTo: lesson)
          .orderBy("updateTime", descending: false)
          .snapshots()
          .map((snap) => snap.docs.map((doc) => WordNewModel.fromJson(doc.data())).toList());
    }
  }

  @override
  Future<void> setUp(User user) async {
    final List<WordNewModel> wordList = await _firebaseFirestore.collection(tWordPath).get().then((docs) {
      return docs.docs.map((doc) {
        return WordNewModel.fromJson(doc.data());
      }).toList();
    });

    for (WordNewModel word in wordList) {
      Future.wait([
        _firebaseFirestore.collection(tUserPath).doc(user.uid).collection(tWordPath).doc(word.word).set(word
            .copyWith(
              id: word.word,
            )
            .toJson()),
        _firebaseFirestore.collection(tUserPath).doc(user.uid).collection(tLevelPath).doc(word.level).set({
          "id": word.level,
          "label": word.level,
          "locked": wordList.indexOf(word) == 0 ? false : true,
        }),
        _firebaseFirestore.collection(tUserPath).doc(user.uid).collection(tLessonPath).doc(word.lesson).set({
          "id": word.lesson,
          "label": word.lesson,
          "level": word.level,
          "locked": wordList.indexOf(word) == 0 ? false : true,
        }),
        _firebaseFirestore.collection(tUserPath).doc(user.uid).set({
          "email": user.email,
          "id": user.uid,
        }),
      ]).then((value) => log("Succesful!"));
    }
  }

  @override
  Future<void> swipeCard(String userId, WordNewModel word, bool swipeRight) async {
    await _firebaseFirestore
        .collection(tUserPath)
        .doc(userId)
        .collection(tWordPath)
        .doc(word.id)
        .update({
          "box": (swipeRight && word.box < 4) ? word.box + 1 : word.box,
          "updateTime": Timestamp.fromDate(DateTime.now()),
        })
        .then((value) => log("Successful!"))
        .onError((error, stackTrace) => log("Something went wrong."));
  }

  @override
  Future<void> setLevel() async {
    final List<LevelModel> levelList = LevelModel.levelList;

    for (LevelModel level in levelList) {
      final updatedLevel = level.copyWith(id: level.label);

      await _firebaseFirestore
          .collection(tLevelPath)
          .doc(level.label)
          .set(updatedLevel.toJson(), SetOptions(merge: true))
          .then((value) => log("Successful!"));
    }
  }

  @override
  Future<void> setLesson() async {
    final List<LessonModel> lessonList = LessonModel.lessonList;

    for (LessonModel lesson in lessonList) {
      final updatedLesson = lesson.copyWith(id: lesson.label);

      await _firebaseFirestore
          .collection(tLessonPath)
          .doc(lesson.label)
          .set(updatedLesson.toJson(), SetOptions(merge: true))
          .then((value) => log("Successful!"));
    }
  }

  @override
  Future<void> updateWords() async {
    final wordList = WordNewModel.wordList;

    for (WordNewModel word in wordList) {
      Future.wait([
        _firebaseFirestore.collection(tWordPath).doc(word.word).set(word
            .copyWith(
              id: word.word,
            )
            .toJson()),
        _firebaseFirestore.collection(tLevelPath).doc(word.level).set({
          "id": word.level,
          "label": word.level,
          "locked": wordList.indexOf(word) == 0 ? false : true,
        }),
        _firebaseFirestore.collection(tLessonPath).doc(word.lesson).set({
          "id": word.lesson,
          "label": word.lesson,
          "level": word.level,
          "locked": wordList.indexOf(word) == 0 ? false : true,
        }),
      ]).then((value) => log("Succesful!"));
    }
  }

  @override
  Future<void> unlockLesson(String userId, LessonModel lesson, String level) async {
    final List<LessonModel> lessonList = await getLessons(userId, level).first;
    final int index = lessonList.indexOf(lesson);
    final String nextLesson = lessonList[index + 1].label;

    _firebaseFirestore
        .collection(tUserPath)
        .doc(userId)
        .collection(tLessonPath)
        .doc(nextLesson)
        .update({"locked": false}).then((value) => log("Lesson unlocked! $lesson"));
  }

  @override
  Future<void> addLevel(LevelModel level) async {
    await _firebaseFirestore
        .collection(tLevelPath)
        .doc(level.label)
        .set(level.toJson())
        .then((value) => log("Succesful!"));
  }

  @override
  Future<void> addLesson(LessonModel lesson) async {
    await _firebaseFirestore
        .collection(tLessonPath)
        .doc(lesson.label)
        .set(lesson.toJson())
        .then((value) => log("Successful!"));
  }

  @override
  Future<void> addWord(WordNewModel word) async {
    await _firebaseFirestore.collection(tWordPath).doc(word.word).set(word.toJson()).then((value) => log("Succesful!"));
  }
}
