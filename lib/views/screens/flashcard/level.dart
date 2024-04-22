import 'package:flaapp/model/level.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/services/networks/word.dart';
import 'package:flaapp/views/screens/flashcard/lesson.dart';
import 'package:flaapp/views/widgets/body/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final Word word = Provider.of<Word>(context, listen: false);
  //     word.updateLevelListStream();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Word word = Provider.of<Word>(context);
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();
    final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("LEVELS"),
        actions: [
          IconButton(
            onPressed: () {
              auth.logout();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      // drawer: CustomDrawer(
      //   profile: widget.profile,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              children: LevelModel.levelList.map((level) {
                // final int index = levelList.indexOf(level);

                return GestureDetector(
                  onTap: !level.locked
                      ? () async {
                          nav.pushScreen(context,
                              screen: LessonScreen(
                                levelId: level.id,
                              ));
                          // await word.addLessons(levelId: level.id).then((value) {
                          //   nav.pushScreen(context,
                          //       screen: LessonScreen(
                          //         levelId: level.id,
                          //       ));
                          // });
                        }
                      : null,
                  child: Container(
                    height: 210,
                    width: size.width * 0.43,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: level.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
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
                          level.id,
                          style: theme.textTheme.headlineLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          level.locked ? Icons.lock : Icons.check_circle,
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
        // body: StreamWrapper<List<LevelModel>>(
        //   stream: word.levelListStream,
        //   child: (data) {
        //     final List<LevelModel> levelList = data!;

        //     return SafeArea(
        //       child: SingleChildScrollView(
        //         child: Padding(
        //           padding: const EdgeInsets.all(16.0),
        //           child: Wrap(
        //             spacing: 15,
        //             runSpacing: 15,
        //             children: levelList.map((level) {
        //               // final int index = levelList.indexOf(level);

        //               return GestureDetector(
        //                 onTap: !level.locked
        //                     ? () async {
        //                         await word.addLessons(levelId: level.id).then((value) {
        //                           nav.pushScreen(context,
        //                               screen: LessonScreen(
        //                                 levelId: level.id,
        //                               ));
        //                         });
        //                       }
        //                     : null,
        //                 child: Container(
        //                   height: 210,
        //                   width: size.width * 0.43,
        //                   padding: const EdgeInsets.symmetric(vertical: 20.0),
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(15.0),
        //                     color: level.locked ? ColorTheme.tGreyColor : ColorTheme.tBlueColor,
        //                   ),
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       // Text(
        //                       //   level.difficulty,
        //                       //   style: theme.textTheme.bodyLarge!.copyWith(
        //                       //     color: Colors.white,
        //                       //   ),
        //                       // ),
        //                       Text(
        //                         level.id,
        //                         style: theme.textTheme.headlineLarge!.copyWith(
        //                           color: Colors.white,
        //                           fontSize: 45.0,
        //                           fontWeight: FontWeight.w600,
        //                         ),
        //                       ),
        //                       Icon(
        //                         level.locked ? Icons.lock : Icons.check_circle,
        //                         color: Colors.white,
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               );
        //             }).toList(),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
