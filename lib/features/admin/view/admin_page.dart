import 'package:flaapp/features/admin/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/view/admin_view.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';
import 'package:flaapp/repository/user/user_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatelessWidget {
  static String route = "/admin_page_route";
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminBloc(
            levelRepository: context.read<LevelRepository>(),
            lessonRepository: context.read<LessonRepository>(),
            wordRepository: context.read<WordRepository>(),
            translateRepository: context.read<TranslateRepository>(),
          )..add(const AdminInitRequested()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: context.read<AuthRepository>(),
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: const AdminView(),
    );
  }
}
