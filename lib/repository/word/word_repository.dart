import 'dart:async';

import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/translation.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/word/base_word_repository.dart';
import 'package:flaapp/utils/constant/strings/constant.dart';

class WordRepository extends BaseWordRepository {
  final DatabaseRepository databaseRepository;

  WordRepository({
    required this.databaseRepository,
  });

  @override
  Future<List<WordModel>> getWords({
    required String levelId,
    required String lessonId,
  }) async {
    final words = await databaseRepository.collectionToList(
      path: "levels/$levelId/lessons/$lessonId/words",
      builder: (data, _) => WordModel.fromJson(data),
    );

    return words;
  }

  @override
  Stream<List<WordModel>> getUserWords({
    required String userId,
    required String levelId,
    required String lessonId,
  }) {
    return databaseRepository.collectionStream(
      path: "users/$userId/user_words",
      builder: (data, _) => WordModel.fromJson(data),
    );
  }

  @override
  Future<void> addUserWord({
    required String userId,
    required String levelId,
    required String lessonId,
  }) async {
    final words = await databaseRepository.collectionToList(
      path: "levels/$levelId/lessons/$lessonId/words",
      builder: (data, _) => WordModel.fromJson(data),
    );

    if (words.isEmpty) {
      throw Exception("Word not found");
    }

    for (var word in words) {
      await databaseRepository.setData(
        path: "users/$userId/user_words/${word.id}",
        data: word.copyWith(box: 0).toJson(),
      );
    }
  }

  @override
  Future<void> swipeCard({
    required WordModel word,
    required bool swipedRight,
    required String userId,
  }) async {
    final updatedBox = word.box! + 1;

    await databaseRepository.setData(
      path: "users/$userId/words/${word.id}",
      data: word
          .copyWith(
            box: swipedRight ? updatedBox : word.box,
            updateTime: DateTime.now(),
          )
          .toJson(),
    );
  }

  @override
  Future<void> lockCard({
    required WordModel word,
    required String userId,
  }) async {
    DateTime date = DateTime.now();

    switch (word.box) {
      case 1:
        date = date.add(const Duration(minutes: 1));
      case 2:
        date = date.add(const Duration(minutes: 5));
      case 3:
        date = date.add(const Duration(minutes: 10));
      case 4:
        date = date.add(const Duration(minutes: 15));
    }

    await databaseRepository.setData(
      path: "users/$userId/words/${word.id}",
      data: word
          .copyWith(
            lockedTime: date,
          )
          .toJson(),
    );
  }

  @override
  Stream<int?> lockCardStream({
    required WordModel word,
    required String userId,
  }) {
    return Stream.periodic(const Duration(seconds: 1), (int count) {
      final now = DateTime.now();
      final lockedTime = word.lockedTime;

      if (lockedTime != null) {
        final remainingSeconds = lockedTime.difference(now).inSeconds;
        if (remainingSeconds <= 0) {
          return 0;
        }
        return remainingSeconds;
      }
      return null;
    }).takeWhile((remainingSeconds) =>
        remainingSeconds != null && remainingSeconds >= 0);
  }

  @override
  Future<void> unLockCard({
    required WordModel word,
    required String userId,
  }) async {
    await databaseRepository.setData(
      path: "users/$userId/words/${word.id}",
      data: word
          .copyWith(
            lockedTime: null,
          )
          .toJson(),
    );
  }

  @override
  Stream<List<WordModel>> getAdminWords({
    required String level,
    required String lesson,
  }) {
    return databaseRepository.collectionStream(
      path: "words",
      queryBuilder: (query) {
        return query
            .where("level.id", isEqualTo: level)
            .where("lesson.id", isEqualTo: lesson);
      },
      builder: (data, _) => WordModel.fromJson(data),
    );
  }

  @override
  Future<void> adminAddWord({
    required LevelModel level,
    required LessonModel lesson,
    required String us,
    required String de,
    required String es,
  }) async {
    final int length = await databaseRepository.getCount(path: "words");
    final id = length.toString().padLeft(4, "0");
    final WordModel word = WordModel(
      id: id,
      word: us,
      translations: [
        Translation(word: us, language: "us"),
        Translation(word: de, language: "de"),
        Translation(word: es, language: "es"),
      ],
      levelId: level.id,
      lessonId: lesson.id,
      updateTime: DateTime.now(),
    );

    await databaseRepository.setData(
      path: "words/$id",
      data: word.toJson(),
    );
  }

  @override
  Future<void> deleteWordLesson(String word) async {
    await databaseRepository.deleteData(collection: "words", doc: word);
  }

  @override
  Future<void> updateAdminWord(WordModel word) async {
    await databaseRepository.setData(
      path: "$tWordPath/${word.id}",
      data: word.toJson(),
      merge: true,
    );
  }
}
