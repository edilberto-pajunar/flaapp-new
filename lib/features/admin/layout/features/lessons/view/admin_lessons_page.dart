import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/features/lessons/view/admin_lessons_view.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLessonsPage extends StatelessWidget {
  static const route = "/admin/lessons";
  const AdminLessonsPage({
    required this.levelModel,
    super.key,
  });

  final LevelModel levelModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(
        levelRepository: context.read<LevelRepository>(),
        lessonRepository: context.read<LessonRepository>(),
        wordRepository: context.read<WordRepository>(),
        translateRepository: context.read<TranslateRepository>(),
      )..add(AdminLessonStreamRequested(levelId: levelModel.id ?? "")),
      child: AdminLessonsView(
        levelModel: levelModel,
      ),
    );
  }
}
