import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/word/bloc/card_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/features/word/utils/word_sheet.dart';
import 'package:flaapp/features/word/widget/progress_card.dart';
import 'package:flaapp/features/word/widget/flash_card.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/user.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';

class WordView extends StatefulWidget {
  final LessonModel lesson;

  const WordView({
    required this.lesson,
    super.key,
  });

  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  @override
  void initState() {
    super.initState();
    context.read<WordBloc>().add(WordInitRequested(
          user: context.read<AppBloc>().state.currentUser!,
          levelId: widget.lesson.levelId ?? "",
          lessonId: widget.lesson.id ?? "",
        ));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Word"),
      ),
      body: BlocConsumer<WordBloc, WordState>(
        listenWhen: (previous, current) =>
            previous.wordLoadingStatus != current.wordLoadingStatus ||
            previous.wordFavoriteStatus != current.wordFavoriteStatus,
        listener: (context, state) {
          // if (state.lockedStatus == LockedStatus.locked) {
          //   context.read<WordBloc>().add(WordTimerInitRequested(
          //         words: state.words,
          //       ));
          // }

          // if (state.completeStatus == CompleteStatus.finished) {
          //   context.pop();
          //   showCompleteDialog(context);
          // }
          if (state.words.isNotEmpty) {
            if (state.wordLoadingStatus == WordLoadingStatus.success) {
              final getUserWordsWithLeastBox = state.userWords.reduce(
                  (currentMin, word) =>
                      word.box! < currentMin.box! ? word : currentMin);
              context.read<CardBloc>().add(CardProgressIndexChanged(
                    currentBox: getUserWordsWithLeastBox.box ?? 0,
                  ));
            }
          }

          if (state.wordFavoriteStatus == WordFavoriteStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Word added to favorites"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.wordLoadingStatus == WordLoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.words.isEmpty) {
            return const Center(
              child: Text("No words found"),
            );
          }

          return BlocConsumer<CardBloc, CardState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, cardState) {
              final currentWords = state.userWords
                  .where((element) =>
                      element.box == cardState.currentProgressIndex)
                  .toList();
              if (currentWords.isEmpty &&
                  cardState.status == CardStateStatus.success) {
                if (cardState.currentProgressIndex == 4) {
                  context.read<WordBloc>().add(WordCompleted(
                        userId: context.read<AppBloc>().state.currentUser!.uid,
                        levelId: widget.lesson.levelId ?? "",
                        lessonId: widget.lesson.id ?? "",
                      ));
                  WordSheet.completed(context);
                }
                context.read<CardBloc>().add(CardProgressIndexChanged(
                      currentBox: cardState.currentProgressIndex + 1,
                    ));
              }
            },
            builder: (context, cardState) {
              final currentWords = state.userWords
                  .where((element) =>
                      element.box == cardState.currentProgressIndex)
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProgressCard(
                      state: state,
                      cardState: cardState,
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
                    BlocSelector<AppBloc, AppState, AppUserInfo?>(
                      selector: (state) => state.currentUserInfo,
                      builder: (context, userInfo) {
                        return Flexible(
                          child: cardState.status == CardStateStatus.loading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CardSwiper(
                                  allowedSwipeDirection:
                                      AllowedSwipeDirection.only(
                                    right: true,
                                    left: true,
                                  ),
                                  threshold: 100,
                                  numberOfCardsDisplayed: currentWords.length,
                                  isLoop: true,
                                  onSwipe: (int previousIndex,
                                      int? currentIndex,
                                      CardSwiperDirection direction) {
                                    context.read<CardBloc>().add(CardSwiped(
                                          wordId:
                                              currentWords[previousIndex].id ??
                                                  "",
                                          direction: direction,
                                          userId: userInfo?.id ?? "",
                                          box:
                                              currentWords[previousIndex].box ??
                                                  0,
                                        ));

                                    return true;
                                  },
                                  onSwipeDirectionChange:
                                      (horizontalDirection, verticalDirection) {
                                    if (horizontalDirection.index == 0 &&
                                        verticalDirection.index == 0) {
                                      return context
                                          .read<CardBloc>()
                                          .add(CardSwipedDirectionChanged(
                                            direction: CardSwiperDirection.none,
                                          ));
                                    }
                                    context
                                        .read<CardBloc>()
                                        .add(CardSwipedDirectionChanged(
                                          direction: horizontalDirection ==
                                                  CardSwiperDirection.left
                                              ? CardSwiperDirection.left
                                              : CardSwiperDirection.right,
                                        ));
                                  },
                                  cardBuilder: (context, index,
                                      percentTresholdX, percentTresholdY) {
                                    return BlocSelector<AppBloc, AppState,
                                        AppUserInfo?>(
                                      selector: (state) {
                                        return state.currentUserInfo;
                                      },
                                      builder: (context, userInfo) {
                                        return FlashCard(
                                          word: currentWords[index],
                                          wordState: state,
                                          cardState: cardState,
                                          codeToLearn:
                                              userInfo?.codeToLearn ?? "",
                                        );
                                      },
                                    );
                                  },
                                  cardsCount: currentWords.length,
                                ),
                        );
                      },
                    ),
                    // state.lockedStatus == LockedStatus.locked
                    //     ? const LockedCard()
                    //     : Draggable(
                    //         feedback: FlashCard(
                    //           word: words[0],
                    //           wordBloc: context.read<WordBloc>(),
                    //         ),
                    //         onDragUpdate: (details) {
                    //           context
                    //               .read<WordBloc>()
                    //               .add(WordCardUpdateDragged(details: details));
                    //         },
                    //         onDragEnd: (details) {
                    //           context.read<WordBloc>().add(WordCardEndDragged(
                    //                 details: details,
                    //                 word: words[0],
                    //               ));

                    //           unlockLesson(context, words);
                    //         },
                    //         childWhenDragging: words.length > 1
                    //             ? FlashCard(
                    //                 word: words[1],
                    //                 wordBloc: context.read<WordBloc>(),
                    //               )
                    //             : Container(),
                    //         child: FlashCard(
                    //           word: words[0],
                    //           wordBloc: context.read<WordBloc>(),
                    //         ),
                    //       ),
                  ],
                ),
              );
            },
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
            lessons: context.read<LessonBloc>().state.lessons,
            lesson: widget.lesson,
          ));
    }
  }

  void showCompleteDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Image.asset(PngImage.ribbon),
            content: const Text(
              "Congratulations, you have completed this lesson!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text(
                  "Go to next level",
                ),
              ),
            ],
          );
        });
  }
}
