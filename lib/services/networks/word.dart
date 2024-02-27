import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/services/constant/strings/constant.dart';
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
    final path = _db.collection(tUserPath)
        .doc(id).collection(tLevelPath)
        .doc(levelId).collection(tLessonPath);

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

      if (lessonListDb.isEmpty) {
        await path.doc(data.doc).set({
          tLessonPath: data.toJson(),
        }, SetOptions(merge: true)).then((value) => debugPrint("Successful!"))
            .onError((error, stackTrace) => debugPrint("Error: $error"));
      }
    }
  }

  Stream<List<LessonModel>>? lessonListStream;

  Stream<List<LessonModel>> getLessonListStream({
    required String levelId,
  }) {

    final String id = _auth.currentUser!.uid;

    return _db.collection(tUserPath)
        .doc(id).collection(tLevelPath).doc(levelId)
        .collection(tLessonPath).snapshots().map((event) {

        return event.docs.map((data) {
          final map = data.data();

          return LessonModel.fromJson(map[tLessonPath]);
        }).toList();

    });
  }

  void updateLessonListStream({
    required String levelId,
  }) {
    lessonListStream = getLessonListStream(
      levelId: levelId
    );
    notifyListeners();
  }

  Stream<LessonModel>? lessonStream;

  Stream<LessonModel> getLessonStream({
    required String levelId,
    required String lessonId,
  }) {

    final String id = _auth.currentUser!.uid;

    return _db.collection(tUserPath)
        .doc(id).collection(tLevelPath).doc(levelId)
        .collection(tLessonPath).doc(lessonId).snapshots().map((event) {
      final map = event.data()!;

      return LessonModel.fromJson(map[tLessonPath]);
    });
  }

  void updateLessonStream({
    required String levelId,
    required String lessonId,
  }) {
    lessonStream = getLessonStream(
        levelId: levelId,
        lessonId: lessonId
    );
    notifyListeners();
  }

  Stream<List<WordModel>>? wordListStream;

  Stream<List<WordModel>> getWordListStream({
    required String levelId,
    required String lessonId,
  }) {

    final String id = _auth.currentUser!.uid;

    return _db.collection(tUserPath)
        .doc(id).collection(tLevelPath).doc(levelId)
        .collection(tLessonPath).doc(lessonId).snapshots().map((event) {
          final map = event.data()!;

        return (map[tLessonPath][tWordPath] as List).map((e) => WordModel.fromJson(e)).toList();
    });
  }

  void updateWordListStream({
    required String levelId,
    required String lessonId,
  }) {
    wordListStream = getWordListStream(
      levelId: levelId,
      lessonId: lessonId,
    );
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

  Size screenSize = Size.zero;

  /// [setScreenSize] initialize to detect the width of the mobile
  void setScreenSize(Size screenSize) {
    this.screenSize = screenSize;
    notifyListeners();
  }

  bool isFrontSide = false;


  /// [updateFlipCard] update if front or back the current card
  void updateFlipCard() {
    isFrontSide = !isFrontSide;
    notifyListeners();
  }

  bool isDragging = false;

  /// [startPosition] triggers when start to drag the card
  void startPosition(DragStartDetails details) {
    isDragging = true;
    notifyListeners();
  }

  Offset position = Offset.zero;
  double angle = 0;

  /// [updatePosition] triggers when dragging the card
  void updatePosition(DragUpdateDetails details) {
    position += details.delta;

    final x = position.dx;
    angle = 45 * x / screenSize.width;

    notifyListeners();
  }


  /// [endPosition] triggers when the user stops dragging the card
  void endPosition(DragEndDetails details, {
    required LessonModel lessonModel,
    required String levelId,
  }) {
    isDragging = false;
    notifyListeners();

    final status = getStatus();

    switch (status) {
      case CardStatus.right:
        angle = 20;
        position += Offset(screenSize.width * 2, 0);
        nextCard(lessonModel: lessonModel, levelId: levelId);

        notifyListeners();
        break;

      case CardStatus.left:
        break;

      default:
        resetPosition();
    }

    resetPosition();
  }

  /// [getStatus] check whether the user swipes to the
  /// right or left
  CardStatus getStatus() {
    final x = position.dx;

    const delta = 100;

    if (x >= delta) {
      return CardStatus.right;
    } else if (x <= -delta) {
      return CardStatus.left;
    } else {
      return CardStatus.none;
    }
  }

  /// [resetPosition] returns to default after end of drag
  void resetPosition() {
    isDragging = false;
    position = Offset.zero;
    angle = 0;

    notifyListeners();
  }

  final NavigationServices nav = NavigationServices();

  Future<void> nextCard({
    required String levelId,
    required LessonModel lessonModel,
  }) async {
    final String id = _auth.currentUser!.uid;
    final DateTime now = DateTime.now();

    final path = _db.collection(tUserPath).doc(id)
      .collection(tLevelPath).doc(levelId)
      .collection(tLessonPath).doc(lessonModel.doc);

    List<WordModel> wordList = await path.get().then((value) {
      final map = value.data()!;
      return (map[tLessonPath][tWordPath] as List).map((e) => WordModel.fromJson(e)).toList();
    });

    final List<WordModel> notSelectedWords = wordList.where((element) {
      return element.box != boxIndex;
    }).toList();


    List<WordModel> currentWords = selectedWords(wordList, boxIndex);

    currentWords[0] = currentWords[0].copyWith(
      box: currentWords[0].box + 1
    );

    final List<WordModel> updatedWords = [...notSelectedWords, ...currentWords];

    await path.set({
      tLessonPath: {
        "words": updatedWords.map((e) =>  e.toJson())
      }
    }, SetOptions(merge: true)).then((value) {
      return debugPrint("Updated successful!");
    })
      .onError((error, stackTrace) => debugPrint("Error: $error"));

    wordList = await path.get().then((value) {
      final map = value.data()!;
      return (map[tLessonPath][tWordPath] as List).map((e) => WordModel.fromJson(e)).toList();
    });

    currentWords = selectedWords(wordList, boxIndex);

    if (currentWords.isEmpty) {
      boxIndex += 1;

      await path.set({
        tLessonPath: {
          "timeConstraint": now.add(const Duration(minutes: 5)),
        }
      }, SetOptions(merge: true))
        .then((value) {
          return debugPrint("Updated time successful!");
      })
        .onError((error, stackTrace) => debugPrint("Error: $stackTrace"));

    }
    notifyListeners();
  }
}
