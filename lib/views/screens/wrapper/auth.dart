import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/views/screens/auth/login.dart';
import 'package:flaapp/views/screens/flashcard/level.dart';
import 'package:flaapp/views/widgets/body/stream_builder.dart';
import 'package:flutter/material.dart';

class AuthWrapperScreen extends StatefulWidget {
  const AuthWrapperScreen({super.key});

  @override
  State<AuthWrapperScreen> createState() => _AuthWrapperScreenState();
}

class _AuthWrapperScreenState extends State<AuthWrapperScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          final User? user = snapshot.data;

          if (user == null) {
            return const LoginScreen();
          } else {
            return const LevelScreen();
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );
  }
}
