import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/word/bloc/card_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/features/word/widget/box_card.dart';
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
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, cardState) {
          return BlocConsumer<WordBloc, WordState>(
            listener: (context, state) {
              if (state.lockedStatus == LockedStatus.locked) {
                context.read<WordBloc>().add(WordTimerInitRequested(
                      words: state.words,
                    ));
              }

              if (state.completeStatus == CompleteStatus.finished) {
                context.pop();
                showCompleteDialog(context);
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

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProgressCard(
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
                    BlocSelector<AppBloc, AppState, AppUserInfo?>(
                      selector: (state) => state.currentUserInfo,
                      builder: (context, userInfo) {
                        print("User info: ${userInfo?.id}");
                        return Flexible(
                          child: CardSwiper(
                            allowedSwipeDirection: AllowedSwipeDirection.only(
                              right: true,
                              left: true,
                            ),
                            threshold: 100,
                            numberOfCardsDisplayed: state.userWords.length,
                            onSwipe: (int previousIndex, int? currentIndex,
                                CardSwiperDirection direction) {
                              print(
                                'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
                              );
                              context.read<CardBloc>().add(CardSwiped(
                                    wordId:
                                        state.userWords[previousIndex].id ?? "",
                                    direction: direction,
                                    userId: userInfo?.id ?? "",
                                    box:
                                        state.userWords[previousIndex].box ?? 0,
                                  ));
                              return true;
                            },
                            onEnd: () {},
                            onUndo: (previousIndex, currentIndex, direction) {
                              print(
                                'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
                              );

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
                            cardBuilder: (context, index, percentTresholdX,
                                percentTresholdY) {
                              return BlocSelector<AppBloc, AppState,
                                  AppUserInfo?>(
                                selector: (state) {
                                  return state.currentUserInfo;
                                },
                                builder: (context, userInfo) {
                                  return FlashCard(
                                    word: state.userWords[index],
                                    wordState: state,
                                    cardState: cardState,
                                    codeToLearn: userInfo?.codeToLearn ?? "",
                                  );
                                },
                              );
                            },
                            cardsCount: state.userWords.length,
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
            user: context.read<AppBloc>().state.currentUser!,
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
