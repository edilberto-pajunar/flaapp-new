import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/features/favorite/view/favorite_page.dart';
import 'package:flaapp/features/lesson/view/lesson_page.dart';
import 'package:flaapp/features/level/bloc/level_bloc.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
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
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: ColorTheme.tBlueColor,
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    "Flaapp",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            ListTile(
              title: const Text("Favorites"),
              leading: const Icon(Icons.star),
              onTap: () => context.pushNamed(FavoritePage.route),
            ),
            const Divider(),
            ListTile(
              title: const Text("About"),
              leading: const Icon(Icons.info),
              onTap: () {},
            ),
            const Divider(),
          ],
        ),
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
                                    context.pushNamed(LessonPage.route, extra: {
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
                                    level.label.toUpperCase(),
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
