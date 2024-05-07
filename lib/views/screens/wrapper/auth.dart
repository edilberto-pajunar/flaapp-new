import 'dart:developer';

import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/views/screens/admin/admin_screen.dart';
import 'package:flaapp/views/screens/auth/login.dart';
import 'package:flaapp/views/screens/flashcard/level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapperScreen extends StatefulWidget {
  const AuthWrapperScreen({super.key});

  @override
  State<AuthWrapperScreen> createState() => _AuthWrapperScreenState();
}

class _AuthWrapperScreenState extends State<AuthWrapperScreen> {
  @override
  Widget build(BuildContext context) {
    final NavigationServices nav = NavigationServices();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        log("${state.status}");
        if (state.status == AuthStatus.authenticated) {
          if (state.user!.uid == "0XxNPuZWIyURc1PrddS6BUNEsGX2") {
            nav.replaceScreen(context, screen: const AdminScreen());
          } else {
            nav.replaceScreen(context, screen: const LevelScreen());
          }
        } else if (state.status == AuthStatus.unknown || state.status == AuthStatus.unauthenticated) {
          nav.replaceScreen(context, screen: const LoginScreen());
        }
      },
      child: Container(),
    );

    // return StreamBuilder<User?>(
    //   stream: auth.user,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       final User? user = snapshot.data;
    //       if (user == null) {
    //         return const LoginScreen();
    //       } else {
    //         if (user.uid == "0XxNPuZWIyURc1PrddS6BUNEsGX2") {
    //           return const AdminScreen();
    //         } else {
    //           return const LevelScreen();
    //         }
    //       }
    //     } else if (snapshot.data == null) {
    //       return const LoginScreen();
    //     } else if (snapshot.hasError) {
    //       return Center(
    //         child: Text("Error: ${snapshot.error}"),
    //       );
    //     } else {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // );
  }
}
