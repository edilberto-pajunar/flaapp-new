import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/repository/auth/base_auth_repository.dart';
import 'package:flaapp/repository/database/database_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get user => _firebaseAuth.authStateChanges();

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<User?> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await DatabaseRepository().setData(
        path: "users/${cred.user!.uid}",
        data: {
          "email": email,
          "id": cred.user!.uid,
          "username": username,
          "language": "English",
          "code": "en",
        },
      );

      return cred.user!;
    } catch (e) {
      log("Error: $e");
    }

    return null;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
