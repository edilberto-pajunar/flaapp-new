import 'dart:math';

import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/values/constant/strings/image.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/services/networks/word.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashCardWidget<T> extends StatefulWidget {
  const FlashCardWidget({
    required this.wordList,
    required this.levelId,
    required this.lessonModel,
    required this.word,
    required this.isFront,
    required this.time,
    super.key,
  });

  final List<WordModel> wordList;
  final LessonModel lessonModel;
  final String levelId;
  final WordModel word;
  final bool isFront;
  final String time;

  @override
  State<FlashCardWidget<T>> createState() => _FlashCardWidgetState<T>();
}

class _FlashCardWidgetState<T> extends State<FlashCardWidget<T>> {

  bool isActivated(Word word, int latestEmptyIndex) {
    final List<WordModel> latestSelectedWords = word.selectedWords(widget.wordList, latestEmptyIndex);
    if (word.boxIndex == latestEmptyIndex) {
      return latestSelectedWords.length == widget.wordList.length && word.getActivated(latestEmptyIndex, widget.time);
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Word word = Provider.of<Word>(context);

    final int latestEmptyIndex = word.latestEmptyIndex(widget.wordList);
    final bool activated = isActivated(word, latestEmptyIndex);

    return const Text("");

    // if (activated) {
    //   if (widget.isFront) {
    //     return buildFrontCard(context);
    //   } else {
    //     return buildCard(context);
    //   }
    // } else {
    //   return buildEmptyCard(context);
    // }
  }

  // Widget buildFrontCard(context) {
  //   final Word word = Provider.of<Word>(context);

  //   return GestureDetector(
  //     onPanStart: (details) {
  //       word.startPosition(details);
  //     },
  //     onPanUpdate: (details) {
  //       word.updatePosition(details);
  //     },
  //     onPanEnd: (details) {
  //       word.endPosition(details,
  //         levelId: widget.levelId,
  //         lessonModel: widget.lessonModel,
  //       );
  //     },
  //     onTap: () {
  //       word.updateFlipCard();
  //     },
  //     child: LayoutBuilder(builder: (context, constraints) {
  //       final milliseconds = word.isDragging ? 0 : 400;

  //       final center = constraints.smallest.center(Offset.zero);
  //       final angle = word.angle * pi / 180;
  //       final rotatedMatrix = Matrix4.identity()
  //         ..translate(center.dx, center.dy)
  //         ..rotateZ(angle)
  //         ..translate(-center.dx, -center.dy);

  //       return AnimatedContainer(
  //         alignment: Alignment.center,
  //         curve: Curves.easeInOut,
  //         duration: Duration(milliseconds: milliseconds),
  //         transform: rotatedMatrix..translate(word.position.dx, word.position.dy),
  //         child: buildCard(context),
  //       );
  //     }),
  //   );
  // }

  // Widget buildCard(BuildContext context) {
  //   final Size size = MediaQuery.of(context).size;
  //   final ThemeData theme = Theme.of(context);
  //   final Word word = Provider.of<Word>(context);

  //   String getCardWord() {
  //     final Word word = Provider.of<Word>(context);

  //     if (word.getStatus() == CardStatus.left) {
  //       return "You got this. Let's try again!";
  //     } else if (word.getStatus() == CardStatus.right) {
  //       return "Great!";
  //     } else {
  //       return "";
  //     }
  //   }

  //   Color getCardColor() {
  //     final Word word = Provider.of<Word>(context);

  //     if (word.getStatus() == CardStatus.left) {
  //       return ColorTheme.tRedColor;
  //     } else if (word.getStatus() == CardStatus.right) {
  //       return ColorTheme.tGreenColor;
  //     } else {
  //       return ColorTheme.tBlueColor;
  //     }
  //   }

  //   String getTranslatedWord() {
  //     switch (0) {
  //       case 0:
  //         return widget.word.translations[0];
  //       case 1:
  //         return widget.word.translations[1];
  //       case 2:
  //         return widget.word.translations[2];
  //       default:
  //         return widget.word.word;
  //     }
  //   }

  //   return Container(
  //     height: size.height * 0.58,
  //     decoration: BoxDecoration(
  //       color: getCardColor(),
  //       borderRadius: BorderRadius.circular(24.0),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(
  //             left: 28.0,
  //             top: 22.0,
  //             right: 28.0,
  //           ),
  //           child: Align(
  //             alignment: word.getStatus() == CardStatus.left
  //                 ? Alignment.topRight
  //                 : Alignment.topLeft,
  //             child: Text(getCardWord(),
  //               style: theme.textTheme.bodyMedium!.copyWith(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: Center(
  //             child: Text(word.isFrontSide
  //                 ? widget.word.word
  //                 : getTranslatedWord(),
  //               style: theme.textTheme.headlineLarge!.copyWith(
  //                 color: ColorTheme.tWhiteColor,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Visibility(
  //           child: Padding(
  //             padding: const EdgeInsets.all(6.0),
  //             child: Container(
  //               padding: const EdgeInsets.symmetric(vertical: 9.0),
  //               decoration: BoxDecoration(
  //                 color: ColorTheme.tWhiteColor,
  //                 borderRadius: const BorderRadius.only(
  //                   bottomLeft: Radius.circular(23.0),
  //                   bottomRight: Radius.circular(23.0),
  //                 ),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const Text("Click to flip the card",
  //                   ),
  //                   const SizedBox(width: 6.0),
  //                   Image.asset(PngImage.pointingUp),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildEmptyCard(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Container(
      height: size.height * 0.58,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(24.0),
      ),
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
              child: Text(
                "Come back soon after the timer is finished",
                style: theme.textTheme.bodyLarge!.copyWith(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Icon(
                Icons.lock,
                size: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
