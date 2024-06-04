import 'package:flaapp/cubit/login/login_cubit.dart';
import 'package:flaapp/cubit/signup/signup_cubit.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/features/auth/view/auth_view.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  static String route = "auth_page_route";
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const AuthView(),
    );
  }
}
