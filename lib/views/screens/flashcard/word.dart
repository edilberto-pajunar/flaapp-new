import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/services/constant/theme/colors.dart';
import 'package:flaapp/services/networks/word.dart';
import 'package:flaapp/views/screens/flashcard/components/box_card.dart';
import 'package:flaapp/views/screens/flashcard/components/flash_card.dart';
import 'package:flaapp/views/widgets/body/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({
    required this.lessonModel,
    required this.levelId,
    super.key,
  });

  final LessonModel lessonModel;
  final String levelId;

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> with SingleTickerProviderStateMixin {
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initTicker(scaffoldKey.currentContext!);
    });
  }

  void initTicker(BuildContext context) {

    final Word word = Provider.of<Word>(context, listen: false);

    ticker = createTicker((elapsed) {
      word.updateWordListStream(
        levelId: widget.levelId,
        lessonId: widget.lessonModel.doc,
      );

      word.updateLessonStream(
        levelId: widget.levelId,
        lessonId: widget.lessonModel.doc,
      );
    })..start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

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

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("A1 Greetings"),
      ),
      body: StreamWrapper<LessonModel>(
        stream: word.lessonStream,
        child: (data) {
          final LessonModel lesson = data!;

          return StreamWrapper<List<WordModel>>(
            stream: word.wordListStream,
            child: (data) {
              final List<WordModel> wordList = data!;

              final List<WordModel> selectedWords = wordList.where((element) {
                return element.box == word.boxIndex;
              }).toList();

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
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 0 : 5.0,
                              ),
                              child: BoxCard(
                                index: index,
                                wordList: wordList,
                                lessonModel: widget.lessonModel,
                                time: remainingTime(lesson),
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
                      Stack(
                        children: selectedWords.map((word) {

                          final int index = selectedWords.indexOf(word);

                          return FlashCardWidget(
                            wordList: wordList,
                            levelId: widget.levelId,
                            lessonModel: widget.lessonModel,
                            word: selectedWords[index],
                            isFront: selectedWords.first == word,
                            time: remainingTime(lesson),
                          );
                        }).toList().reversed.toList(),
                      ),
                      const SizedBox(height: 12.0),
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}
