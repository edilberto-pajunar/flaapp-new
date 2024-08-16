import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/features/words/view/admin_words_view.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminWordsPage extends StatelessWidget {
  static const route = "/admin/words";
  const AdminWordsPage({
    required this.levelId,
    required this.lessonId,
    super.key,
  });

  final String levelId;
  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(
        levelRepository: context.read<LevelRepository>(),
        lessonRepository: context.read<LessonRepository>(),
        wordRepository: context.read<WordRepository>(),
        translateRepository: context.read<TranslateRepository>(),
      )..add(AdminWordStreamRequested(
          levelId: levelId,
          lessonId: lessonId,
        )),
      child: const AdminWordsView(),
    );
  }
}
