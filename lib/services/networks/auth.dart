import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/user.dart';
import 'package:flaapp/services/constant/strings/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
      await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      ).then((value) async {
        final String id = value.user!.uid;

        final UserModel userModel = UserModel(email: email.text, name: name.text);
        final String level = await rootBundle.loadString(tLevelJson);

        final List mapLevel = (jsonDecode(level)[tLevelPath]) as List;

        await _db.collection(tUserPath).doc(id).set(userModel.toJson());

        for (Map data in mapLevel) {
          final levelDoc = data["doc"];

          await _db.collection(tUserPath)
              .doc(id).collection(tLevelPath)
              .doc(levelDoc).set({
            "id": levelDoc,
          }).then((value) => debugPrint("Successful!"))
            .onError((error, stackTrace) => debugPrint("Error: $error"));
        }
      });
      showHUD(false);
    } catch (e) {
      showHUD(false);
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> login() async {
    showHUD(true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text, password: password.text,
      );
    } catch (e) {
      showHUD(false);
    }
  }
}
