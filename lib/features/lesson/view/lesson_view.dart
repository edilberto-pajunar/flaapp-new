import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/word/view/word_page.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LessonView extends StatefulWidget {
  final LevelModel level;

  const LessonView({
    required this.level,
    super.key,
  });

  @override
  State<LessonView> createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> {
  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(LessonInitRequested(
          user: context.read<AppBloc>().state.currentUser!,
          levelId: widget.level.id ?? "",
        ));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson"),
      ),
      body: BlocBuilder<LessonBloc, LessonState>(
        builder: (context, state) {
          final lessons = state.lessons;

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
                              final userLesson = state.userLessons.firstWhere(
                                (userLesson) => userLesson.id == lesson.id,
                                orElse: () => lesson,
                              );
                              final lessonLocked = userLesson.locked ?? true;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: lessonLocked
                                          ? ColorTheme.tGreyColor
                                          : ColorTheme.tBlueColor,
                                      width: 4.0,
                                    ),
                                    top: BorderSide(
                                      color: lessonLocked
                                          ? ColorTheme.tGreyColor
                                          : ColorTheme.tBlueColor,
                                    ),
                                    left: BorderSide(
                                      color: lessonLocked
                                          ? ColorTheme.tGreyColor
                                          : ColorTheme.tBlueColor,
                                    ),
                                    right: BorderSide(
                                      color: lessonLocked
                                          ? ColorTheme.tGreyColor
                                          : ColorTheme.tBlueColor,
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15.0),
                                  onTap: !lessonLocked
                                      ? () {
                                          context.pushNamed(WordPage.route,
                                              extra: {
                                                "level": widget.level,
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
                                            lesson.label ?? "",
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22.0,
                                            ),
                                          ),
                                        ),
                                        if (lessonLocked)
                                          Icon(
                                            Icons.lock_outline,
                                            color: ColorTheme.tGreyColor,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
