import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/database/base_database_repository.dart';
import 'package:flaapp/values/constant/strings/constant.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<T?> getData<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) async {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final DocumentSnapshot snapshot = await reference.get();

    if (!snapshot.exists) return null;

    return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  @override
  Future<void> setData<T>({
    required String path,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  @override
  Future<void> setBatchData({
    required String baseColPath,
    String endPath = "",
    required Map<String, dynamic> Function(String p1) dataFromId,
    Query<Object?> Function(Query<Object?> query)? queryBuilder,
    bool merge = false,
  }) async {
    final List<String> docIdList = await collectionToList(
      path: baseColPath,
      builder: (_, docId) => docId,
      queryBuilder: queryBuilder,
    );

    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (final docId in docIdList) {
      final path = "$baseColPath/$docId/$endPath";
      final reference = FirebaseFirestore.instance.doc(path);
      batch.set(reference, dataFromId(docId), SetOptions(merge: true));
    }

    return batch.commit();
  }

  @override
  Future<void> setBatchDataForDocInList({
    required String baseColPath,
    required List<String> docIdList,
    required Map<String, dynamic> Function(String) dataFromId,
    bool merge = true,
  }) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (final docId in docIdList) {
      final path = '$baseColPath/$docId';
      final reference = FirebaseFirestore.instance.doc(path);
      batch.set(reference, dataFromId(docId), SetOptions(merge: merge));
    }

    return batch.commit();
  }

  StreamSubscription? _colStreamSub;
  StreamSubscription? _docStreamSub;

  @override
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query<Object?> Function(Query<Object?> query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
    bool isCollectionGroup = false,
  }) {
    final streamController = StreamController<List<T>>();
    final firestore = FirebaseFirestore.instance;
    Query query = isCollectionGroup
        ? firestore.collectionGroup(path)
        : firestore.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final Stream<QuerySnapshot> snapshots = query.snapshots();
    _colStreamSub = snapshots.listen(
      (snapshot) {
        final result = snapshot.docs
            .map((snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((value) => value != null)
            .toList();

        if (sort != null) {
          result.sort(sort);
        }

        if (!streamController.isClosed) {
          streamController.add(result);
        }
      },
      onError: (error) {
        if (error is FirebaseException && error.code == "permission-denied") {
          // Do nothing, this exception is expected behavior due to
          // rules laid out in firestore.rules
          return;
        }
      },
      cancelOnError: true,
    );

    streamController.onCancel = streamController.close;
    return streamController.stream;
  }

  @override
  Stream<T?> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) {
    final streamController = StreamController<T?>();
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    _docStreamSub = snapshots.listen(
      (snapshot) {
        final data = snapshot.data();
        if (streamController.isClosed) return;
        if (data != null) {
          streamController.add(builder(
            snapshot.data() as Map<String, dynamic>,
            snapshot.id,
          ));
        } else {
          streamController.add(null);
        }
      },
      onError: (error) {
        if (error is FirebaseException && error.code == "permission-denied") {
          // Do nothing, this exception is expected behavior due to
          // rules laid out in firestore.rules
          return;
        }
      },
      cancelOnError: true,
    );

    streamController.onCancel = streamController.close;

    return streamController.stream;
  }

  @override
  Future<List<T>> collectionToList<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query<Object?> Function(Query<Object?> query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final Future<QuerySnapshot> snapshots = query.get();

    return snapshots.then((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();

      if (sort != null) {
        result.sort(sort);
      }

      return result;
    });
  }

  @override
  Stream<List<LevelModel>> getLevels(String? userId) {
    if (userId == null) {
      return _firebaseFirestore
          .collection(tLevelPath)
          .orderBy("label")
          .snapshots()
          .map((snap) {
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
        return event.docs
            .map((doc) => LevelModel.fromJson(doc.data()))
            .toList();
      });
    }
  }

  @override
  Stream<List<LessonModel>> getLessons(String? userId, String? level) {
    if (userId == null) {
      return _firebaseFirestore
          .collection(tLessonPath)
          .where("level", isEqualTo: level)
          .snapshots()
          .map((snap) {
        return snap.docs
            .map((doc) => LessonModel.fromJson(doc.data()))
            .toList();
      });
    } else {
      return _firebaseFirestore
          .collection(tUserPath)
          .doc(userId)
          .collection(tLessonPath)
          .where("level", isEqualTo: level)
          .snapshots()
          .map((snap) {
        return snap.docs
            .map((doc) => LessonModel.fromJson(doc.data()))
            .toList();
      });
    }
  }

  @override
  Stream<List<WordModel>> getWords(
      String? userId, String level, String lesson) {
    if (userId == null) {
      return _firebaseFirestore
          .collection(tWordPath)
          .where("level", isEqualTo: level)
          .where("lesson", isEqualTo: lesson)
          .orderBy("updateTime", descending: false)
          .snapshots()
          .map((snap) =>
              snap.docs.map((doc) => WordModel.fromJson(doc.data())).toList());
    } else {
      return _firebaseFirestore
          .collection(tUserPath)
          .doc(userId)
          .collection(tWordPath)
          .where("level", isEqualTo: level)
          .where("lesson", isEqualTo: lesson)
          .orderBy("updateTime", descending: false)
          .snapshots()
          .map((snap) =>
              snap.docs.map((doc) => WordModel.fromJson(doc.data())).toList());
    }
  }

  @override
  Future<void> setUp(User user) async {
    final List<WordModel> wordList =
        await _firebaseFirestore.collection(tWordPath).get().then((docs) {
      return docs.docs.map((doc) {
        return WordModel.fromJson(doc.data());
      }).toList();
    });

    for (WordModel word in wordList) {
      Future.wait([
        _firebaseFirestore
            .collection(tUserPath)
            .doc(user.uid)
            .collection(tWordPath)
            .doc(word.word)
            .set(word
                .copyWith(
                  id: word.word,
                )
                .toJson()),
        _firebaseFirestore
            .collection(tUserPath)
            .doc(user.uid)
            .collection(tLevelPath)
            .doc(word.level.id)
            .set({
          "id": word.level,
          "label": word.level,
          "locked": wordList.indexOf(word) == 0 ? false : true,
        }),
        _firebaseFirestore
            .collection(tUserPath)
            .doc(user.uid)
            .collection(tLessonPath)
            .doc(word.lesson.id)
            .set({
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
  Future<void> swipeCard(String userId, WordModel word, bool swipeRight) async {
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
  Future<void> updateWords() async {
    // final wordList = WordModel.wordList;

    // try {
    //   for (WordModel word in wordList) {
    //     setData(
    //       path: "$tWordPath/${word.word}",
    //       data: word.copyWith(id: word.word).toJson(),
    //       merge: true,
    //     );
    //     // _firebaseFirestore.collection(tWordPath).doc(word.word).set(
    //     //       word.copyWith(id: word.word).toJson(),
    //     //       SetOptions(merge: true),
    //     //     );

    //     // _firebaseFirestore.collection(tLevelPath).doc(word.level).set({
    //     //   "id": word.level,
    //     //   "label": word.level,
    //     //   "locked": wordList.indexOf(word) == 0 ? false : true,
    //     // }, SetOptions(merge: true)),

    //     // _firebaseFirestore.collection(tLessonPath).doc(word.lesson).set({
    //     //   "id": word.lesson,
    //     //   "label": word.lesson,
    //     //   "level": word.level,
    //     //   "locked": wordList.indexOf(word) == 0 ? false : true,
    //     // }, SetOptions(merge: true)),
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  Future<void> unlockLesson(
      String userId, LessonModel lesson, String level) async {
    final List<LessonModel> lessonList = await getLessons(userId, level).first;
    final int index = lessonList.indexOf(lesson);
    final String nextLesson = lessonList[index + 1].label;

    _firebaseFirestore
        .collection(tUserPath)
        .doc(userId)
        .collection(tLessonPath)
        .doc(nextLesson)
        .update({"locked": false}).then(
            (value) => log("Lesson unlocked! $lesson"));
  }

  @override
  Future<void> unlockLevel(String userId, String level) async {
    final List<LevelModel> levelList = await getLevels(userId).first;
    final int index = levelList.indexWhere((element) => element.label == level);

    final String nextLevel = levelList[index + 1].label;

    _firebaseFirestore
        .collection(tUserPath)
        .doc(userId)
        .collection(tLevelPath)
        .doc(nextLevel)
        .update({"locked": false}).then(
            (value) => log("Level unlocked! $level"));
  }

  @override
  Future<void> addLevel(LevelModel level) async {
    await _firebaseFirestore
        .collection(tLevelPath)
        .doc(level.label)
        .set(level.toJson(), SetOptions(merge: true))
        .then((value) => log("Succesful!"));
  }

  @override
  Future<void> addLesson(LessonModel lesson) async {
    await _firebaseFirestore
        .collection(tLessonPath)
        .doc(lesson.id)
        .set(lesson.toJson(), SetOptions(merge: true))
        .then((value) => log("Successful!"));
  }

  @override
  Future<void> addWord(WordModel word) async {
    await _firebaseFirestore
        .collection(tWordPath)
        .doc(word.word)
        .set(word.toJson(), SetOptions(merge: true))
        .then(
          (value) => log("Succesful!"),
        );
  }

  @override
  Future<void> deleteData({
    required String collection,
    required String doc,
  }) async {
    _firebaseFirestore.collection(collection).doc(doc).delete();
  }

  @override
  Future<int> getCount({
    required String path,
  }) async {
    return await _firebaseFirestore
        .collection(path)
        .get()
        .then((value) => value.size);
  }
}
