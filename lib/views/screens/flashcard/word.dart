import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/values/constant/strings/image.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/services/networks/word.dart';
import 'package:flaapp/views/screens/flashcard/components/box_card.dart';
import 'package:flaapp/views/widgets/body/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({
    required this.level,
    required this.lesson,
    // required this.lessonModel,
    // required this.levelId,
    super.key,
  });

  // final LessonModel lessonModel;
  // final String levelId;
  final String level;
  final String lesson;

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> with SingleTickerProviderStateMixin {
  // late Ticker ticker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // initTicker(scaffoldKey.currentContext!);
      final Word word = Provider.of<Word>(context, listen: false);
      context.read<Auth>().user.listen((currentUser) {
        word.updateWordNewStream(id: currentUser!.uid, lesson: widget.lesson, level: widget.level);

        word.wordStream!.listen((event) {
          word.updateBoxIndex(event.last.box);
        });
      });
    });
  }

  // void initTicker(BuildContext context) {
  //   final Word word = Provider.of<Word>(context, listen: false);

  //   ticker = createTicker((elapsed) {
  //     word.updateWordListStream(
  //       levelId: widget.levelId,
  //       lessonId: widget.lessonModel.doc,
  //     );

  //     word.updateLessonStream(
  //       levelId: widget.levelId,
  //       lessonId: widget.lessonModel.doc,
  //     );
  //   })
  //     ..start();
  // }

  // @override
  // void dispose() {
  //   ticker.dispose();
  //   super.dispose();
  // }

  String remainingTime(LessonModel lesson) {
    final DateTime now = DateTime.now();
    final DateTime? timeConstraint = lesson.timeConstraint;

    if (timeConstraint != null && timeConstraint.isAfter(now)) {
      final difference = timeConstraint.difference(now);

      int hour = difference.inHours;
      int minute = difference.inMinutes % 60;
      int second = difference.inSeconds % 60;

      return '$hour:$minute:$second';
    } else {
      return "0";
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final Word word = Provider.of<Word>(context);
    final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("A1 Greetings"),
      ),
      body: StreamWrapper<User?>(
          stream: auth.user,
          child: (data) {
            final user = data!;

            return StreamWrapper(
                stream: word.wordStream,
                child: (data) {
                  final wordStream = data!;
                  final currentWords = data.where((element) => element.box == word.boxIndex).toList();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.13,
                            child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // return Padding(
                                //   padding: EdgeInsets.only(
                                //     left: index == 0 ? 0 : 5.0,
                                //   ),
                                //   child: BoxCard(
                                //     index: index,
                                //     wordList: wordList,
                                //     lessonModel: widget.lessonModel,
                                //     time: remainingTime(lesson),
                                //   ),
                                // );
                                return SizedBox(
                                  width: size.width * 0.19,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 12,
                                        child: InkWell(
                                          onTap: wordStream.where((element) => element.box == index).isEmpty
                                              ? null
                                              : () => word.updateBoxIndex(index),
                                          child: Container(
                                            height: 80,
                                            width: size.width * 0.17,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12.0),
                                              color: ColorTheme.tTertiaryBlueColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 4.0,
                                                  color: Colors.black.withOpacity(0.25),
                                                ),
                                              ],
                                              border: word.boxIndex == index
                                                  ? Border.all(
                                                      color: ColorTheme.tBlueColor,
                                                      width: 2.0,
                                                    )
                                                  : null,
                                            ),
                                            child: Center(
                                              child: wordStream.where((element) => element.box == index).isEmpty
                                                  ? const Icon(Icons.lock)
                                                  : Stack(
                                                      children: [
                                                        Center(
                                                          child: Image.asset(
                                                            true ? PngImage.card : PngImage.cardDeactivated,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            "${wordStream.where((element) => element.box == index).length}",
                                                            style: theme.textTheme.bodyMedium!.copyWith(
                                                              color: ColorTheme.tWhiteColor,
                                                              fontSize: 20.0,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
                          // Stack(
                          //   children: selectedWords
                          //       .map((word) {
                          //         final int index = selectedWords.indexOf(word);

                          //         return FlashCardWidget(
                          //           wordList: wordList,
                          //           levelId: widget.levelId,
                          //           lessonModel: widget.lessonModel,
                          //           word: selectedWords[index],
                          //           isFront: selectedWords.first == word,
                          //           time: remainingTime(lesson),
                          //         );
                          //       })
                          //       .toList()
                          //       .reversed
                          //       .toList(),
                          // ),
                          InkWell(
                            onTap: () {
                              word.updateFlipCard();
                            },
                            child: Draggable(
                              feedback: FlashCard(wordModel: currentWords[0]),
                              onDragUpdate: word.updatePosition,
                              onDragEnd: (details) {
                                if (details.offset.dx < -100) {
                                  print("Swipe left");
                                  word.swipeCard(id: user.uid, word: currentWords[0]);
                                } else if (details.offset.dx > 100) {
                                  word.swipeCard(id: user.uid, word: currentWords[0], swipeRight: true);
                                  print("Swipe right");
                                }

                                word.resetPosition();
                              },
                              childWhenDragging: currentWords.length > 1
                                  ? FlashCard(
                                      wordModel: currentWords[1],
                                    )
                                  : Container(),
                              child: FlashCard(
                                wordModel: currentWords[0],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12.0),
                        ],
                      ),
                    ),
                  );
                });
          }),
      // body: StreamWrapper<LessonModel>(
      //   stream: word.lessonStream,
      //   child: (data) {
      //     final LessonModel lesson = data!;

      //     return StreamWrapper<List<WordModel>>(
      //       stream: word.wordListStream,
      //       child: (data) {
      //         final List<WordModel> wordList = data!;

      //         final List<WordModel> selectedWords = wordList.where((element) {
      //           return element.box == word.boxIndex;
      //         }).toList();

      //         return Padding(
      //           padding: const EdgeInsets.all(16.0),
      //           child: SingleChildScrollView(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 SizedBox(
      //                   height: size.height * 0.13,
      //                   child: ListView.builder(
      //                     itemCount: 5,
      //                     shrinkWrap: true,
      //                     scrollDirection: Axis.horizontal,
      //                     itemBuilder: (context, index) {
      //                       return Padding(
      //                         padding: EdgeInsets.only(
      //                           left: index == 0 ? 0 : 5.0,
      //                         ),
      //                         child: BoxCard(
      //                           index: index,
      //                           wordList: wordList,
      //                           lessonModel: widget.lessonModel,
      //                           time: remainingTime(lesson),
      //                         ),
      //                       );
      //                     },
      //                   ),
      //                 ),
      //                 const SizedBox(height: 24.0),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Row(
      //                       children: [
      //                         Icon(
      //                           Icons.arrow_back_outlined,
      //                           color: ColorTheme.tBlackColor,
      //                           size: 28.0,
      //                         ),
      //                         SizedBox(
      //                           width: 100,
      //                           child: Text(
      //                             "Swipe left to relearn",
      //                             style: theme.textTheme.bodyMedium!.copyWith(
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     Row(
      //                       children: [
      //                         SizedBox(
      //                           width: 100,
      //                           child: Text(
      //                             "Swipe right for next",
      //                             style: theme.textTheme.bodyMedium!.copyWith(
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                             textAlign: TextAlign.end,
      //                           ),
      //                         ),
      //                         Icon(
      //                           Icons.arrow_forward,
      //                           color: ColorTheme.tBlackColor,
      //                           size: 28.0,
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 12.0),
      //                 Stack(
      //                   children: selectedWords.map((word) {

      //                     final int index = selectedWords.indexOf(word);

      //                     return FlashCardWidget(
      //                       wordList: wordList,
      //                       levelId: widget.levelId,
      //                       lessonModel: widget.lessonModel,
      //                       word: selectedWords[index],
      //                       isFront: selectedWords.first == word,
      //                       time: remainingTime(lesson),
      //                     );
      //                   }).toList().reversed.toList(),
      //                 ),
      //                 const SizedBox(height: 12.0),
      //               ],
      //             ),
      //           ),
      //         );
      //       }
      //     );
      //   }
      // ),
    );
  }
}

class FlashCard extends StatelessWidget {
  const FlashCard({
    super.key,
    required this.wordModel,
  });

  final WordNewModel wordModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final Word word = Provider.of<Word>(context);

    return Container(
      decoration: BoxDecoration(
        color: word.position.dx > 0
            ? ColorTheme.tGreenColor
            : word.position.dx < 0
                ? ColorTheme.tRedColor
                : ColorTheme.tBlueColor,
        borderRadius: BorderRadius.circular(24.0),
      ),
      height: size.height * 0.6,
      width: size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 28.0,
              top: 22.0,
              right: 28.0,
            ),
            child: Align(
              alignment: word.position.dx > 0 ? Alignment.topRight : Alignment.topLeft,
              child: Text(
                word.position.dx > 0
                    ? "Great!"
                    : word.position.dx < 0
                        ? "You got this. Let's try again!"
                        : "",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                word.isFrontSide ? wordModel.word : wordModel.translations[0],
                style: theme.textTheme.headlineLarge!.copyWith(
                  color: ColorTheme.tWhiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                decoration: BoxDecoration(
                  color: ColorTheme.tWhiteColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(23.0),
                    bottomRight: Radius.circular(23.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "Click to flip the card",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Image.asset(PngImage.pointingUp),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
