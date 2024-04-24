import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/repository/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => print("Login Successful!"))
          .onError((error, stackTrace) => print("Error: $error"));
    } catch (e) {}
  }

  @override
  Future<void> signup({required String email, required String password}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => print("Create Account Successful!"))
          .onError((error, stackTrace) => print("Error: $error"));
    } catch (e) {}
  }
}
