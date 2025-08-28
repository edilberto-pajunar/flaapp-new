import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/features/favorite/view/favorite_page.dart';
import 'package:flaapp/features/lesson/view/lesson_page.dart';
import 'package:flaapp/features/level/bloc/level_bloc.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LevelView extends StatefulWidget {
  const LevelView({super.key});

  @override
  State<LevelView> createState() => _LevelViewState();
}

class _LevelViewState extends State<LevelView> {
  @override
  void initState() {
    super.initState();
    context.read<LevelBloc>().add(LevelInitRequested(
          user: context.read<AppBloc>().state.currentUser!,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
      body: BlocBuilder<LevelBloc, LevelState>(
        builder: (context, state) {
          if (state.levels.isEmpty) {
            return Text("No levels");
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: state.levels.length,
                      itemBuilder: (context, index) {
                        final level = state.levels[index];
                        final userLevel = state.userLevels.firstWhere(
                          (userLevel) => userLevel.id == level.id,
                          orElse: () => level,
                        );
                        final levelLocked = userLevel.locked ?? true;

                        return Opacity(
                          opacity: levelLocked ? 0.2 : 1,
                          child: GestureDetector(
                            onTap: !levelLocked
                                ? () {
                                    context.pushNamed(LessonPage.route, extra: {
                                      "level": level,
                                    });
                                  }
                                : null,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: ColorTheme.tBlueColor,
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
                                    level.label?.toUpperCase() ?? "",
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    levelLocked
                                        ? Icons.lock
                                        : Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
