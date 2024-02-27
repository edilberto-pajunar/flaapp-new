import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/services/constant/strings/image.dart';
import 'package:flaapp/services/constant/theme/colors.dart';
import 'package:flaapp/services/networks/word.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxCard extends StatefulWidget {
  const BoxCard({
    required this.wordList,
    required this.onTap,
    required this.index,
    required this.lessonModel,
    super.key,
  });

  final List<WordModel> wordList;
  final int index;
  final Function()? onTap;
  final LessonModel lessonModel;

  @override
  State<BoxCard> createState() => _BoxCardState();
}

class _BoxCardState extends State<BoxCard> {


  int time() {
    final DateTime now = DateTime.now();
    final DateTime? timeConstraint = widget.lessonModel.timeConstraint;

    if (timeConstraint != null) {
      if (now.isBefore(timeConstraint)) {
        final difference = now.subtract(Duration(hours: timeConstraint.hour)).hour;
        return difference;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final Word word = Provider.of<Word>(context);

    final bool isCurrentBox = word.boxIndex == widget.index;
    final List<WordModel> selectedWords = word.selectedWords(widget.wordList, widget.index);


    return SizedBox(
      width: 70,
      child: Stack(
        children: [
          Positioned(
            top: 12,
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                height: 80,
                width: size.width * 0.17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: !isCurrentBox ? ColorTheme.tBorderColor : ColorTheme.tTertiaryBlueColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4.0,
                      color: isCurrentBox ? Colors.black.withOpacity(0.25) : Colors.white,
                    ),
                  ],
                  border: isCurrentBox ? Border.all(
                    color: ColorTheme.tBlueColor,
                    width: 2.0,
                  ) : null,
                ),
                child: Center(
                  child: false
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
                        child: Text("${selectedWords.length}",
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
          Positioned(
            left: 28,
            child: Visibility(
              visible: time() != 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  color:ColorTheme.tLightBlueColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text("${time()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.2,
                    fontSize: 8.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
