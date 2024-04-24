import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/repository/database/base_database_repository.dart';
import 'package:flaapp/values/constant/strings/constant.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<WordNewModel>> getUserWords(String userId) {
    return _firebaseFirestore
        .collection(tUserPath)
        .doc(userId)
        .collection(tWordPath)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => WordNewModel.fromJson(doc.data())).toList());
  }
}
