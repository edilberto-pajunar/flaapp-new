import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/bloc/lesson/lesson_bloc.dart';
import 'package:flaapp/features/level/bloc/level_bloc.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/views/screens/flashcard/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    required this.levelId,
    super.key,
  });

  final String levelId;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("LESSONS"),
      ),
      body: BlocProvider(
        create: (context) => LessonBloc(
          databaseRepository: context.read<DatabaseRepository>(),
          authBloc: context.read<AuthBloc>(),
          level: widget.levelId,
          levelBloc: context.read<LevelBloc>(),
        )..add(LessonStarted(level: widget.levelId)),
        child: BlocBuilder<LessonBloc, LessonState>(
          builder: (context, state) {
            if (state is LessonLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LessonLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.lessonList.length,
                          itemBuilder: (context, index) {
                            final LessonModel lesson = state.lessonList[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border(
                                  bottom: BorderSide(
                                    color: lesson.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                                    width: 4.0,
                                  ),
                                  top: BorderSide(
                                    color: lesson.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                                  ),
                                  left: BorderSide(
                                    color: lesson.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                                  ),
                                  right: BorderSide(
                                    color: lesson.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.0),
                                onTap: !lesson.locked
                                    ? () {
                                        nav.pushScreen(scaffoldKey.currentContext!,
                                            screen: WordsScreen(
                                              level: widget.levelId,
                                              lesson: lesson,
                                            ));
                                      }
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 18.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          lesson.label,
                                          style: theme.textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                            // return isUnlocked(index)
                            //   ? buildLessonsCard(lesson, wordProvider)
                            //   : buildCompletedCard(lesson, wordProvider);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("Something went wrong."),
              );
            }
          },
        ),
      ),
    );
  }
}
