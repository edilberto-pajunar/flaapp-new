import 'dart:async';

import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/word/base_word_repository.dart';

class WordRepository extends BaseWordRepository {
  final DatabaseRepository databaseRepository;

  WordRepository({
    required this.databaseRepository,
  });

  @override
  Stream<List<WordModel>> getWords({
    required String userId,
    required String level,
    required String lesson,
  }) {
    return databaseRepository.collectionStream(
      path: "users/$userId/words",
      queryBuilder: (query) {
        return query
            .where("level", isEqualTo: level)
            .where("lesson", isEqualTo: lesson)
            .orderBy("updateTime", descending: false);
      },
      builder: (data, _) => WordModel.fromJson(data),
    );
  }

  @override
  Future<void> swipeCard({
    required WordModel word,
    required bool swipedRight,
    required String userId,
  }) async {
    await databaseRepository.setData(
      path: "users/$userId/words/${word.word}",
      data: word
          .copyWith(
            box: swipedRight ? word.box + 1 : word.box,
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
      path: "users/$userId/words/${word.word}",
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

      if (lockedTime == null || lockedTime.isBefore(now)) {
        return null;
      }

      return lockedTime.difference(now).inSeconds;
    }).takeWhile((remainingSeconds) => remainingSeconds != null);
  }

  @override
  Future<void> unLockCard({
    required WordModel word,
    required String userId,
  }) async {
    await databaseRepository.setData(
      path: "users/$userId/words/${word.word}",
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
            .where("level", isEqualTo: level)
            .where("lesson", isEqualTo: lesson);
      },
      builder: (data, _) => WordModel.fromJson(data),
    );
  }

  @override
  Future<void> adminAddWord({
    required WordModel word,
  }) async {
    // final WordModel wordModel = WordModel(
    //   word: word,
    //   translations: const [],
    //   level: level,
    //   lesson: lesson,
    //   updateTime: DateTime.now(),
    // );

    await databaseRepository.setData(
      path: "words",
      data: word.toJson(),
    );
  }
}
