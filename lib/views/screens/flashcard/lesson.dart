import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/services/constant/theme/colors.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/services/networks/word.dart';
import 'package:flaapp/views/screens/flashcard/word.dart';
import 'package:flaapp/views/widgets/body/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    required this.levelId,
    super.key,
  });

  final String levelId;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Word word = Provider.of<Word>(context, listen: false);
      word.updateLessonListStream(levelId: widget.levelId);
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Word word = Provider.of<Word>(context);
    final NavigationServices nav = NavigationServices();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("LESSONS"),
      ),
      body: StreamWrapper<List<LessonModel>>(
        stream: word.lessonListStream,
        child: (data) {
          final List<LessonModel> lessonList = data!;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lessonList.length,
                      itemBuilder: (context, index) {
                        final LessonModel lesson = lessonList[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border(
                              bottom: BorderSide(
                                color: lesson.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                                width: 4.0,
                              ),
                              top: BorderSide(
                                color: lesson.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                              ),
                              left: BorderSide(
                                color: lesson.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                              ),
                              right: BorderSide(
                                color: lesson.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                              ),
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15.0),
                            onTap: !lesson.locked ? () {
                              nav.pushScreen(scaffoldKey.currentContext!, screen: WordsScreen(
                                lessonModel: lesson,
                                levelId: widget.levelId,
                              ));
                            } : null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 18.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(lesson.doc,
                                      style: theme.textTheme.bodyLarge!.copyWith(
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
        }
      ),
    );
  }
}
