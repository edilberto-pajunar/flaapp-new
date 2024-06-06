import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/features/lesson/view/lesson_page.dart';
import 'package:flaapp/features/level/bloc/level_bloc.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LevelView extends StatelessWidget {
  const LevelView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Level"),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<AuthBloc>().add(AuthSignOutAttempted()),
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: BlocSelector<LevelBloc, LevelState, List<LevelModel>>(
        selector: (state) => state.levels,
        builder: (context, levels) {
          return levels.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: levels.map((level) {
                          // final int index = levelList.indexOf(level);

                          return GestureDetector(
                            onTap: !level.locked
                                ? () {
                                    context.push(LessonPage.route, extra: {
                                      "level": level,
                                    });
                                  }
                                : null,
                            child: Container(
                              height: 210,
                              width: size.width * 0.43,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: level.locked
                                    ? ColorTheme.tGreyColor
                                    : ColorTheme.tBlueColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   level.difficulty,
                                  //   style: theme.textTheme.bodyLarge!.copyWith(
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  Text(
                                    level.label,
                                    style:
                                        theme.textTheme.headlineLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    level.locked
                                        ? Icons.lock
                                        : Icons.check_circle,
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
        },
      ),
    );
  }
}
