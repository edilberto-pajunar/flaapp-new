import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/language.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/language/base_language_repository.dart';

class LanguageRepository implements BaseLanguageRepository {
  final DatabaseRepository databaseRepository;
  final FirebaseAuth firebaseAuth;

  LanguageRepository(
      {required this.databaseRepository, required this.firebaseAuth});

  @override
  Stream<List<LanguageModel>> getLanguages() {
    return databaseRepository.collectionStream(
      path: "languages",
      builder: (data, _) => LanguageModel.fromJson(data),
    );
  }

  @override
  Future<void> changeLanguage(LanguageModel language) async {
    final userId = firebaseAuth.currentUser?.uid;
    if (userId == null) {
      throw Exception("User not found");
    }

    await databaseRepository.setData(path: "users/$userId", data: {
      "codeToLearn": language.code,
      "updatedTime": DateTime.now(),
    });
  }
}
