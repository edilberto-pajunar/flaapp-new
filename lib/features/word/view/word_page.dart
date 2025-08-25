import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/features/word/view/word_view.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordPage extends StatelessWidget {
  static String route = "word_page_route";

  final LevelModel level;
  final LessonModel lesson;

  const WordPage({
    required this.level,
    required this.lesson,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<WordBloc>(),
        ),
        BlocProvider.value(
          value: getIt<LessonBloc>(),
        ),
      ],
      child: WordView(
        lesson: lesson,
      ),
    );
  }
}
