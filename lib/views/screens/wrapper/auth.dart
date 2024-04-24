import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/views/screens/admin/admin_screen.dart';
import 'package:flaapp/views/screens/auth/login.dart';
import 'package:flaapp/views/screens/flashcard/level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AuthWrapperScreen extends StatefulWidget {
  const AuthWrapperScreen({super.key});

  @override
  State<AuthWrapperScreen> createState() => _AuthWrapperScreenState();
}

class _AuthWrapperScreenState extends State<AuthWrapperScreen> {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print(state.status);
        if (state.status == AuthStatus.authenticated) {
          return const LevelScreen();
        } else if (state.status == AuthStatus.unknown || state.status == AuthStatus.unauthenticated) {
          return const LoginScreen();
        }
        return const Center(
          child: Text("Something went wrong."),
        );
      },
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
