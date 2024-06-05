import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/word/view/word_page.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LessonView extends StatelessWidget {
  final LevelModel level;

  const LessonView({
    required this.level,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson"),
      ),
      body: BlocSelector<LessonBloc, LessonState, List<LessonModel>>(
        selector: (state) => state.lessons,
        builder: (context, lessons) {
          return lessons.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: lessons.length,
                            itemBuilder: (context, index) {
                              final LessonModel lesson = lessons[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: lesson.locked
                                          ? ColorTheme.tGreyColor
                                          : ColorTheme.tBlueColor,
                                      width: 4.0,
                                    ),
                                    top: BorderSide(
                                      color: lesson.locked
                                          ? ColorTheme.tGreyColor
                                          : ColorTheme.tBlueColor,
                                    ),
                                    left: BorderSide(
                                      color: lesson.locked
                                          ? ColorTheme.tGreyColor
                                          : ColorTheme.tBlueColor,
                                    ),
                                    right: BorderSide(
                                      color: lesson.locked
                                          ? ColorTheme.tGreyColor
                                          : ColorTheme.tBlueColor,
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15.0),
                                  onTap: !lesson.locked
                                      ? () {
                                          context.push(WordPage.route, extra: {
                                            "level": level,
                                            "lesson": lesson,
                                            "lessonBloc":
                                                context.read<LessonBloc>(),
                                          });
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
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
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
        },
      ),
    );
  }
}
