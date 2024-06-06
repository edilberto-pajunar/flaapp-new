import 'package:flaapp/features/admin/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/view/admin_view.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatelessWidget {
  static String route = "/admin_page_route";
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(
        levelRepository: context.read<LevelRepository>(),
        lessonRepository: context.read<LessonRepository>(),
        wordRepository: context.read<WordRepository>(),
        translateRepository: context.read<TranslateRepository>(),
      )..add(const AdminInitRequested()),
      child: const AdminView(),
    );
  }
}
