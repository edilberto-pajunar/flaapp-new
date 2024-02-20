import 'package:flaapp/models/data.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/values/theme/colors.dart';
import 'package:flaapp/views/screens/mobile/flashcard/lessons_screen.dart';
import 'package:flaapp/views/widgets/drawer/custom.dart';
import 'package:flutter/material.dart';

class LevelsScreen extends StatefulWidget {
  static String route = "/levelsScreen";
  const LevelsScreen({
    required this.dataModel,
    super.key,
  });

  final DataModel dataModel;

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();
    final List<LevelModel> levelList = widget.dataModel.levels;
    final List<LessonModel> lessonList = widget.dataModel.lessons;

    // void nextLevel(Level level) {
    //   if (level.unlocked) {
    //     levelProvider.updateLevel(level);
    //     context.push(LessonsScreen.route);
    //   }
    // }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("LEVELS"),
      ),
      drawer: CustomDrawer(
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              children: levelList.map((level) {
                return GestureDetector(
                  onTap: () {
                    nav.pushScreen(context, screen: LessonsScreen(
                      dataModel: widget.dataModel,
                    ));
                  },
                  child: Container(
                    height: 210,
                    width: size.width * 0.43,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: !level.unlocked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   level.difficulty,
                        //   style: theme.textTheme.bodyLarge!.copyWith(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        Text(
                          level.name,
                          style: theme.textTheme.headlineLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          !level.unlocked ? Icons.lock : Icons.check_circle,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      )
    );
  }
}
