import 'package:flaapp/model/language.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/language/base_language_repository.dart';

class LanguageRepository implements BaseLanguageRepository {
  final DatabaseRepository databaseRepository;

  LanguageRepository({required this.databaseRepository});

  @override
  Stream<List<LanguageModel>> getLanguages() {
    return databaseRepository.collectionStream(
      path: "languages",
      builder: (data, _) => LanguageModel.fromJson(data),
    );
  }
}
