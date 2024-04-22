import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/user.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/values/constant/strings/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get user => _auth.authStateChanges();

  bool isLoading = false;

  void showHUD(bool value) {
    isLoading = value;
    notifyListeners();
  }

  static TextEditingController name = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();

  Future<void> signup() async {
    try {
      final auth = await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      final String id = auth.user!.uid;

      print(id);

      await _db.collection(tUserPath).doc(id).set({
        "email": email.text,
        "name": name.text,
      });

      await _db.collection(tWordPath).get().then((snap) async {
        await Future.wait(snap.docs.map((word) async {
          await _db
              .collection(tUserPath)
              .doc(id)
              .collection(tWordPath)
              .doc(word.id)
              .set(word.data())
              .then((value) => print("Successful!"))
              .onError((error, stackTrace) => print("Something went wrong."));
        }));
      });

      // final UserModel userModel = UserModel(email: email.text, name: name.text);
      // final String level = await rootBundle.loadString(tLevelJson);

      // final List mapLevel = (jsonDecode(level)[tLevelPath]) as List;

      // await _db.collection(tUserPath).doc(id).set(userModel.toJson());

      // for (Map data in mapLevel) {
      //   final levelDoc = data["doc"];
      //   final locked = data["locked"];

      //   await _db
      //       .collection(tUserPath)
      //       .doc(id)
      //       .collection(tLevelPath)
      //       .doc(levelDoc)
      //       .set({
      //         "id": levelDoc,
      //         "locked": locked,
      //       })
      //       .then((value) => debugPrint("Successful!"))
      //       .onError((error, stackTrace) => debugPrint("Error: $error"));
      // }
      showHUD(false);
    } catch (e) {
      showHUD(false);
      print("Error: $e");
      rethrow;
    }
  }

  Future<UserCredential?> login() async {
    showHUD(true);

    try {
      final UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      return user;
    } catch (e) {
      showHUD(false);
    }
    return null;
  }

  Stream<User?> get userStream => _auth.userChanges();

  Future<void> logout() async {
    await _auth.signOut();
  }
}
