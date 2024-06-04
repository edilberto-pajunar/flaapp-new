import 'package:flaapp/model/word_new.dart';
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
        query.where("level", isEqualTo: level);
        query.where("lesson", isEqualTo: lesson);

        return query;
      },
      builder: (data, _) => WordModel.fromJson(data),
    );
  }
}
