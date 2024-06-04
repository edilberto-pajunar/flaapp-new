import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/features/word/widget/box_card.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordView extends StatelessWidget {
  const WordView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Word"),
      ),
      body: BlocBuilder<WordBloc, WordState>(
        builder: (context, state) {
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
                          wordStream: state.words,
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
                        // state.duration != null
                        //     ? FlashCard(wordModel: currentWords[0], state: state)
                        //     : InkWell(
                        //         onTap: () {
                        //           context.read<WordBloc>().add(const UpdateFrontSide());
                        //         },
                        //         child: Draggable(
                        //           feedback: FlashCard(
                        //             wordModel: currentWords[0],
                        //             state: state,
                        //           ),
                        //           onDragUpdate: (details) {
                        //             context
                        //                 .read<WordBloc>()
                        //                 .add(DragPosition(details: details));
                        //           },
                        //           onDragEnd: (details) {
                        //             if (details.offset.dx < -100) {
                        //               print("Swipe left");
                        //               // word.swipeCard(id: user.uid, word: currentWords[0]);
                        //               context.read<WordBloc>().add(SwipeCard(
                        //                     wordList: currentWords,
                        //                     currentWord: currentWords[0],
                        //                     swipeRight: false,
                        //                     level: currentWords[0].level,
                        //                     lesson: lesson,
                        //                   ));
                        //             } else if (details.offset.dx > 100) {
                        //               // word.swipeCard(id: user.uid, word: currentWords[0], swipeRight: true);
                        //               print("Swipe right");
                        //               context.read<WordBloc>().add(SwipeCard(
                        //                     wordList: currentWords,
                        //                     currentWord: currentWords[0],
                        //                     swipeRight: true,
                        //                     level: currentWords[0].level,
                        //                     lesson: lesson,
                        //                   ));
                        //             }
                        //           },
                        //           childWhenDragging: currentWords.length > 1
                        //               ? FlashCard(
                        //                   state: state,
                        //                   wordModel: currentWords[1],
                        //                 )
                        //               : Container(),
                        //           child: FlashCard(
                        //             state: state,
                        //             wordModel: currentWords[0],
                        //           ),
                        //         ),
                        //       ),
                        const SizedBox(height: 12.0),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
