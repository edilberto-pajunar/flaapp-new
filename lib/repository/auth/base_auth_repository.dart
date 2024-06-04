import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Stream<User?> get user;

  Future<void> signup({
    required String email,
    required String password,
    required String username,
  });

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
