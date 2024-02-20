import 'package:flaapp/models/data.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/values/theme/colors.dart';
import 'package:flaapp/views/screens/mobile/flashcard/words_screen.dart';
import 'package:flutter/material.dart';

class LessonsScreen extends StatefulWidget {
  static String route = "/lessons";
  const LessonsScreen({
    required this.dataModel,
    super.key,
  });

  final DataModel dataModel;

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final NavigationServices nav = NavigationServices();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<LessonModel> lessonList = widget.dataModel.lessons;
    // final LessonProvider lessonProvider = Provider.of<LessonProvider>(context);

    // void goToFlashCard(Lesson lesson) {
    //   lessonProvider.updateLesson(lesson);
    //   context.push(WordsScreen.route);
    // }



    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("LESSONS"),
      ),
      body:SafeArea(
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

                    return !lesson.unlocked
                        ? buildLessonsCard(lesson)
                        : buildCompletedCard(lesson);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLessonsCard(LessonModel lesson) {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border(
          bottom: BorderSide(
            color: !lesson.unlocked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
            width: 4.0,
          ),
          top: BorderSide(
            color: !lesson.unlocked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
          ),
          left: BorderSide(
            color: !lesson.unlocked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
          ),
          right: BorderSide(
            color: !lesson.unlocked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
          ),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: lesson.unlocked
            ? () {}
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
                  "Lesson ${lesson.name}: ${lesson.description}",
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
  }

  Widget buildCompletedCard(LessonModel lesson) {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0xFF5cb85c),
        border: const Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 4.0,
          ),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: lesson.unlocked
            ? () => nav.pushScreen(context, screen: WordsScreen(
          dataModel: widget.dataModel,
        ))
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
                  "Lesson ${lesson.name}: ${lesson.description}",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                  ),
                ),
              ),
              const Icon(Icons.check_circle_outline_outlined,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
