import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/word.dart';

abstract class BaseDatabaseRepository {
  Future<T?> getData<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  });

  Future<void> setData<T>({
    required String path,
    required Map<String, dynamic> data,
    bool merge = true,
  });

  Future<void> setBatchData({
    required String baseColPath,
    String endPath = "",
    required Map<String, dynamic> Function(String) dataFromId,
    Query Function(Query query)? queryBuilder,
    bool merge = false,
  });

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
    bool isCollectionGroup = false,
  });

  Stream<T?> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  });

  Future<List<T>> collectionToList<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  });

  Future<void> setBatchDataForDocInList({
    required String baseColPath,
    required List<String> docIdList,
    required Map<String, dynamic> Function(String) dataFromId,
    bool merge = true,
  });

  Stream<List<LevelModel>> getLevels(String? userId);
  Stream<List<LessonModel>> getLessons(String? userId, String level);
  Stream<List<WordModel>> getWords(String? userId, String level, String lesson);
  Future<void> setUp(User user);
  Future<void> swipeCard(String userId, WordModel word, bool swipeRight);
  Future<void> updateWords();
  Future<void> unlockLesson(String userId, LessonModel lesson, String level);
  Future<void> unlockLevel(String userId, String level);

  Future<void> addLevel(LevelModel level);
  Future<void> addLesson(LessonModel lesson);
  Future<void> addWord(WordModel word);
}
