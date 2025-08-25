import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/lesson/view/lesson_view.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonPage extends StatelessWidget {
  static String route = "lesson_page_route";

  final LevelModel level;

  const LessonPage({
    required this.level,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonBloc(
        lessonRepository: context.read<LessonRepository>(),
      )..add(LessonInitRequested(
          user: context.read<AppBloc>().state.currentUser!,
          level: level.id ?? "",
        )),
      child: LessonView(
        level: level,
      ),
    );
  }
}
