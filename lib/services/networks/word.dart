import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/values/constant/strings/constant.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum CardStatus { right, none, left }

class Word extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<LevelModel>>? levelListStream;

  Stream<List<LevelModel>> getLevelListStream() {
    final String id = _auth.currentUser!.uid;

    return _db.collection(tUserPath).doc(id).collection(tLevelPath).snapshots().map((event) {
      return event.docs.map((data) {
        final map = data.data();
        return LevelModel.fromJson(map);
      }).toList();
    });
  }

  void updateLevelListStream() {
    levelListStream = getLevelListStream();
    notifyListeners();
  }

  Future<void> addLessons({
    required String levelId,
  }) async {
    final String id = _auth.currentUser!.uid;
    final path = _db.collection(tUserPath).doc(id).collection(tLevelPath).doc(levelId).collection(tLessonPath);

    final String lesson = await rootBundle.loadString(tLessonJson);
    final List mapLesson = (jsonDecode(lesson)[tLessonPath]) as List;

    final List<LessonModel> lessonListLocal = mapLesson.map((e) {
      return LessonModel.fromJson(e);
    }).toList();

    for (var data in lessonListLocal) {
      final List<LessonModel> lessonListDb = await path.get().then((value) {
        return value.docs.map((data) {
          final map = data.data();

          return LessonModel.fromJson(map[tLessonPath]);
        }).toList();
      });

      /// TODO: remove this if you want to generate lessons
      if (lessonListDb.isEmpty) {
        await path
            .doc(data.doc)
            .set({
              tLessonPath: data.toJson(),
            }, SetOptions(merge: true))
            .then((value) => debugPrint("Successful!"))
            .onError((error, stackTrace) => debugPrint("Error: $error"));
      }
    }
  }

  Stream<List<LessonModel>>? lessonListStream;

  Stream<List<LessonModel>> getLessonListStream({
    required String levelId,
  }) {
    final String id = _auth.currentUser!.uid;

    return _db
        .collection(tUserPath)
        .doc(id)
        .collection(tLevelPath)
        .doc(levelId)
        .collection(tLessonPath)
        .snapshots()
        .map((event) {
      return event.docs.map((data) {
        final map = data.data();

        return LessonModel.fromJson(map[tLessonPath]);
      }).toList();
    });
  }

  void updateLessonListStream({
    required String levelId,
  }) {
    lessonListStream = getLessonListStream(levelId: levelId);
    notifyListeners();
  }

  Stream<LessonModel>? lessonStream;

  Stream<LessonModel> getLessonStream({
    required String levelId,
    required String lessonId,
  }) {
    final String id = _auth.currentUser!.uid;

    return _db
        .collection(tUserPath)
        .doc(id)
        .collection(tLevelPath)
        .doc(levelId)
        .collection(tLessonPath)
        .doc(lessonId)
        .snapshots()
        .map((event) {
      final map = event.data()!;

      return LessonModel.fromJson(map[tLessonPath]);
    });
  }

  void updateLessonStream({
    required String levelId,
    required String lessonId,
  }) {
    lessonStream = getLessonStream(levelId: levelId, lessonId: lessonId);
    notifyListeners();
  }

  int boxIndex = 0;

  void updateBoxIndex(int value) {
    boxIndex = value;
    notifyListeners();
  }

  List<WordModel> selectedWords(List<WordModel> wordList, int index) {
    return wordList.where((element) {
      return element.box == index;
    }).toList();
  }

  bool isFrontSide = false;

  /// [updateFlipCard] update if front or back the current card
  void updateFlipCard() {
    isFrontSide = !isFrontSide;
    notifyListeners();
  }

  int indexAddMinute = 0;

  List<int> addMinutesList = [5, 10, 15, 20];

  final NavigationServices nav = NavigationServices();

  Future<void> swipeCard({
    required String id,
    required WordNewModel word,
    bool swipeRight = false,
  }) async {
    await _db
        .collection(tUserPath)
        .doc(id)
        .collection(tWordPath)
        .doc(word.id)
        .update({
          "box": swipeRight ? word.box + 1 : word.box,
          "updateTime": Timestamp.fromDate(DateTime.now()),
        })
        .then((value) => print("Successful!"))
        .onError((error, stackTrace) => print("Something went wrong."));
  }

  Offset position = Offset.zero;

  /// [updatePosition] triggers when dragging the card
  void updatePosition(DragUpdateDetails details) {
    position += details.delta;

    notifyListeners();
  }

  void resetPosition() {
    position = Offset.zero;
    notifyListeners();
  }

  Future<void> nextCard({
    required String levelId,
    required LessonModel lessonModel,
    required CardStatus cardStatus,
  }) async {
    final String id = _auth.currentUser!.uid;
    final DateTime now = DateTime.now();

    final path = _db
        .collection(tUserPath)
        .doc(id)
        .collection(tLevelPath)
        .doc(levelId)
        .collection(tLessonPath)
        .doc(lessonModel.doc);

    List<WordModel> wordList = await path.get().then((value) {
      final map = value.data()!;
      return (map[tLessonPath][tWordPath] as List).map((e) => WordModel.fromJson(e)).toList();
    });

    final List<WordModel> notSelectedWords = wordList.where((element) {
      return element.box != boxIndex;
    }).toList();

    List<WordModel> currentWords = selectedWords(wordList, boxIndex);

    if (currentWords[0].box == 3) {
      await updateLessonLock(levelId: levelId, lessonModel: lessonModel);
    }

    if (cardStatus == CardStatus.right && currentWords[0].box != 4) {
      currentWords[0] = currentWords[0].copyWith(box: currentWords[0].box + 1);
    } else if (cardStatus == CardStatus.left || (cardStatus == CardStatus.right && currentWords[0].box == 4)) {
      WordModel firstWord = currentWords.removeAt(0);
      currentWords.add(firstWord);
    }

    final List<WordModel> updatedWords = [...notSelectedWords, ...currentWords];

    await path.set({
      tLessonPath: {"words": updatedWords.map((e) => e.toJson())}
    }, SetOptions(merge: true)).then((value) {
      return debugPrint("Updated successful!");
    }).onError((error, stackTrace) => debugPrint("Error: $error"));

    wordList = await path.get().then((value) {
      final map = value.data()!;
      return (map[tLessonPath][tWordPath] as List).map((e) => WordModel.fromJson(e)).toList();
    });

    currentWords = selectedWords(wordList, boxIndex);

    if (currentWords.isEmpty) {
      boxIndex += 1;

      await path.set({
        tLessonPath: {
          "timeConstraint": now.add(Duration(minutes: addMinutesList[latestEmptyIndex(wordList) - 1])),
        }
      }, SetOptions(merge: true)).then((value) {
        return debugPrint("Updated time successful!");
      }).onError((error, stackTrace) => debugPrint("Error: $stackTrace"));
    }
    notifyListeners();
  }

  Future<void> updateLessonLock({
    required String levelId,
    required LessonModel lessonModel,
  }) async {
    final String id = _auth.currentUser!.uid;

    final path = _db.collection(tUserPath).doc(id).collection(tLevelPath).doc(levelId).collection(tLessonPath);

    final List<LessonModel> lessonList = await path.get().then((value) {
      return value.docs.map((data) {
        final map = data.data();

        return LessonModel.fromJson(map[tLessonPath]);
      }).toList();
    });

    final int index = lessonList.indexOf(lessonModel);

    print(lessonList.length);
    print(index);

    if (lessonList.length > index && lessonList.length > 1) {
      if (lessonList[index + 1].locked) {
        await path
            .doc(lessonList[index + 1].doc)
            .set({
              tLessonPath: {
                "locked": false,
              }
            }, SetOptions(merge: true))
            .then((value) => debugPrint("Updated lesson successfully!"))
            .onError((error, stackTrace) => debugPrint("Error: $error"));
      }
    }
  }

  bool getActivated(int latestEmptyIndex, String time) {
    if (boxIndex == 0 || latestEmptyIndex > boxIndex) {
      return true;
    } else if (time != "0") {
      return false;
    } else {
      return true;
    }
  }

  int latestEmptyIndex(List<WordModel> wordList) {
    int latestNonEmptyIndex = 0;

    for (int i = 5; i >= 0; i--) {
      final List<WordModel> getSelectedWords = selectedWords(wordList, i);

      if (getSelectedWords.isNotEmpty) {
        latestNonEmptyIndex = i;
        break;
      }
    }
    return latestNonEmptyIndex;
  }

  Stream<List<WordNewModel>> fetchWord(String id, String level, String lesson) {
    return _db
        .collection(tUserPath)
        .doc(id)
        .collection(tWordPath)
        .where("level", isEqualTo: level)
        .where("lesson", isEqualTo: lesson)
        .orderBy("updateTime", descending: false)
        .snapshots()
        .map(
          (snap) => snap.docs.map((doc) {
            return WordNewModel.fromJson(doc.data());
          }).toList(),
        );
  }

  Stream<List<WordNewModel>>? wordStream;

  void updateWordNewStream({
    required String id,
    required String level,
    required String lesson,
  }) {
    wordStream = fetchWord(id, level, lesson);
    notifyListeners();
  }
}
