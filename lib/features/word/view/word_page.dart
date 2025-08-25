import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/features/word/view/word_view.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordPage extends StatelessWidget {
  static String route = "word_page_route";

  final LevelModel level;
  final LessonModel lesson;
  final LessonBloc lessonBloc;

  const WordPage({
    required this.level,
    required this.lesson,
    required this.lessonBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => WordBloc(
        //     wordRepository: context.read<WordRepository>(),
        //     lessonRepository: context.read<LessonRepository>(),
        //     currentUser: context.read<AppBloc>().state.currentUser!,
        //   )..add(WordInitRequested(
        //       level: level.id ?? "",
        //       lesson: lesson.id,
        //     )),
        // ),
        BlocProvider.value(
          value: lessonBloc,
        ),
      ],
      child: WordView(
        lesson: lesson,
      ),
    );
  }
}
