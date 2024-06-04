import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/features/word/view/word_view.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordPage extends StatelessWidget {
  static String route = "/word_page_route";

  final LevelModel level;
  final LessonModel lesson;

  const WordPage({
    required this.level,
    required this.lesson,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WordBloc(wordRepository: context.read<WordRepository>())
            ..add(WordInitRequested(
              user: context.read<AppBloc>().state.currentUser!,
              level: level.label,
              lesson: lesson.label,
            )),
      child: const WordView(),
    );
  }
}
