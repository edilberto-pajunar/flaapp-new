import 'package:flaapp/bloc/level/level_bloc.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/views/screens/flashcard/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text("LEVELS"),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthRepository>().signOut();
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
      body: BlocBuilder<LevelBloc, LevelState>(
        builder: (context, state) {
          if (state is LevelLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LevelLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: state.levelList.map((level) {
                      // final int index = levelList.indexOf(level);

                      return GestureDetector(
                        onTap: !level.locked
                            ? () async {
                                nav.pushScreen(context,
                                    screen: LessonScreen(
                                      levelId: level.label,
                                    ));
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
                                level.label,
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
            );
          } else {
            return const Center(
              child: Text("Something went wrong."),
            );
          }
        },
      ),
    );
  }
}
