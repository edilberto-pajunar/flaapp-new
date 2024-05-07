import 'package:cloud_firestore/cloud_firestore.dart';
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
        .then((value) => print("Successful!"))
        .onError((error, stackTrace) => print("Something went wrong."));
  }

  @override
  Future<void> setUp(String userId) async {
    final List<WordNewModel> wordList = await _firebaseFirestore.collection(tWordPath).get().then((docs) {
      return docs.docs.map((doc) {
        return WordNewModel.fromJson(doc.data());
      }).toList();
    });

    for (WordNewModel word in wordList) {
      _firebaseFirestore
          .collection(tUserPath)
          .doc(userId)
          .collection(tWordPath)
          .doc(word.id)
          .set(
            word.toJson(),
          )
          .then((value) => print("Successful!"));
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
          .then((value) => print("Successful!"));
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
          .then((value) => print("Successful!"));
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
}
