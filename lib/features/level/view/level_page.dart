import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/features/level/bloc/level_bloc.dart';
import 'package:flaapp/features/level/view/level_view.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelPage extends StatelessWidget {
  static String route = "level_page_route";
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LevelBloc(
            levelRepository: context.read<LevelRepository>(),
          )..add(LevelInitRequested(
              user: context.read<AppBloc>().state.currentUser!,
            )),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: const LevelView(),
    );
  }
}
