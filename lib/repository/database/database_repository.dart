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
  Stream<List<WordNewModel>> getUserWords(String userId, String level, String lesson) {
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
  Stream<List<WordNewModel>> getAdminWords(String level, String lesson) {
    return _firebaseFirestore
        .collection(tWordPath)
        .where("level", isEqualTo: level)
        .where("lesson", isEqualTo: lesson)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return WordNewModel.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<void> updateLevel() async {
    final List<LevelModel> levelList = LevelModel.levelList;

    for (LevelModel level in levelList) {
      final String uuid = const Uuid().v1();

      final updatedLevel = level.copyWith(id: uuid);

      await _firebaseFirestore
          .collection(tLevelPath)
          .doc(uuid)
          .set(updatedLevel.toJson(), SetOptions(merge: true))
          .then((value) => log("Successful!"));
    }
  }

  @override
  Future<void> updateLesson() async {
    final List<LessonModel> lessonList = LessonModel.lessonList;

    for (LessonModel lesson in lessonList) {
      final String uuid = const Uuid().v1();

      final updatedLesson = lesson.copyWith(id: uuid);

      await _firebaseFirestore
          .collection(tLessonPath)
          .doc(uuid)
          .set(updatedLesson.toJson(), SetOptions(merge: true))
          .then((value) => log("Successful!"));
    }
  }

  @override
  Stream<List<LevelModel>> getLevels() {
    return _firebaseFirestore.collection(tLevelPath).orderBy("label", descending: false).snapshots().map((snap) {
      return snap.docs.map((doc) => LevelModel.fromJson(doc.data())).toList();
    });
  }

  @override
  Stream<List<LessonModel>> getLessons(String level) {
    return _firebaseFirestore.collection(tLessonPath).where("level", isEqualTo: level).snapshots().map((snap) {
      return snap.docs.map((doc) => LessonModel.fromJson(doc.data())).toList();
    });
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
    final List<LessonModel> lessonList = await getUserLessons(userId, level).first;
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
  Stream<List<LevelModel>> getUserLevels(String userId) {
    return _firebaseFirestore.collection(tUserPath).doc(userId).collection(tLevelPath).snapshots().map((event) {
      return event.docs.map((doc) {
        return LevelModel.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Stream<List<LessonModel>> getUserLessons(
    String userId,
    String level,
  ) {
    return _firebaseFirestore.collection(tUserPath).doc(userId).collection(tLessonPath).snapshots().map((event) {
      return event.docs.map((doc) {
        return LessonModel.fromJson(doc.data());
      }).toList();
    });
  }
}
