import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/features/word/widget/box_card.dart';
import 'package:flaapp/features/word/widget/flash_card.dart';
import 'package:flaapp/features/word/widget/locked_card.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordView extends StatelessWidget {
  final LessonModel lesson;

  const WordView({
    required this.lesson,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Word"),
      ),
      body: BlocBuilder<WordBloc, WordState>(
        builder: (context, state) {
          final words =
              state.words.where((word) => word.box == state.boxIndex).toList();
          return state.words.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BoxCard(
                          state: state,
                        ),
                        const SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_outlined,
                                  color: ColorTheme.tBlackColor,
                                  size: 28.0,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Swipe left to relearn",
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Swipe right for next",
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: ColorTheme.tBlackColor,
                                  size: 28.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        state.lockedTime != null
                            ? const LockedCard()
                            : Draggable(
                                feedback: FlashCard(
                                  word: words[0],
                                  state: state,
                                ),
                                onDragUpdate: (details) {
                                  context.read<WordBloc>().add(
                                      WordCardUpdateDragged(details: details));
                                },
                                onDragEnd: (details) {
                                  context
                                      .read<WordBloc>()
                                      .add(WordCardEndDragged(
                                        details: details,
                                        word: words[0],
                                        user: context
                                            .read<AppBloc>()
                                            .state
                                            .currentUser!,
                                      ));

                                  unlockLesson(context, words);
                                },
                                childWhenDragging: words.length > 1
                                    ? FlashCard(
                                        word: words[1],
                                        state: state,
                                      )
                                    : Container(),
                                child: FlashCard(
                                  word: words[0],
                                  state: state,
                                ),
                              ),
                        const SizedBox(height: 12.0),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  void unlockLesson(
    BuildContext context,
    List<WordModel> words,
  ) {
    if (words.length == 1 && words[0].box == 3) {
      context.read<LessonBloc>().add(LessonUnlockTriggered(
            user: context.read<AppBloc>().state.currentUser!,
            lessons: context.read<LessonBloc>().state.lessons,
            lesson: lesson,
          ));
    }
  }
}
