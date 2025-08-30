import 'dart:async';

import 'package:flaapp/features/admin/layout/features/lessons/view/admin_lessons_page.dart';
import 'package:flaapp/features/admin/layout/features/levels/view/admin_levels_page.dart';
import 'package:flaapp/features/admin/layout/features/words/view/admin_words_page.dart';
import 'package:flaapp/features/admin/layout/view/admin_page.dart';
import 'package:flaapp/features/auth/view/auth_page.dart';
import 'package:flaapp/features/favorite/view/favorite_page.dart';
import 'package:flaapp/features/lesson/view/lesson_page.dart';
import 'package:flaapp/features/level/view/level_page.dart';
import 'package:flaapp/features/word/view/word_page.dart';
import 'package:flaapp/features/wrapper/view/wrapper_page.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthRepository authRepository;

  AppRouter({
    required this.authRepository,
  });

  late final GoRouter config = GoRouter(
      routes: [
        GoRoute(
          name: AuthPage.route,
          path: "/login",
          builder: (context, state) => const AuthPage(),
        ),
        GoRoute(
          name: WrapperPage.route,
          path: "/",
          builder: (context, state) => const WrapperPage(),
          routes: [
            GoRoute(
              name: LevelPage.route,
              path: "/level",
              builder: (context, state) => const LevelPage(),
            ),
            GoRoute(
              name: AdminPage.route,
              path: "/admin",
              builder: (context, state) => const AdminPage(),
              routes: [
                GoRoute(
                  name: AdminLevelsPage.route,
                  path: "levels",
                  builder: (context, state) => const AdminLevelsPage(),
                ),
                GoRoute(
                  name: AdminLessonsPage.route,
                  path: "lessons/:level_id",
                  builder: (context, state) => AdminLessonsPage(
                    levelId: (state.pathParameters as Map)["level_id"],
                    levelLabel: (state.extra as Map)["levelLabel"],
                  ),
                ),
                GoRoute(
                  name: AdminWordsPage.route,
                  path: "words/:level_id/:lesson_id",
                  builder: (context, state) => AdminWordsPage(
                    levelId: (state.pathParameters as Map)["level_id"],
                    lessonId: (state.pathParameters as Map)["lesson_id"],
                  ),
                ),
              ],
            ),
            GoRoute(
              name: FavoritePage.route,
              path: "favorite",
              builder: (context, state) => const FavoritePage(),
            ),
            GoRoute(
              name: LessonPage.route,
              path: "lesson",
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>;
                return LessonPage(level: extra["level"] as LevelModel);
              },
            ),
            GoRoute(
              name: WordPage.route,
              path: "word",
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>;
                return WordPage(
                  level: extra["level"] as LevelModel,
                  lesson: extra["lesson"] as LessonModel,
                );
              },
            ),
          ],
        ),
      ],
      redirect: (context, state) async {
        final currentUser = await authRepository.user.first;

        final isLoggedIn = currentUser != null;
        final loggingIn = state.matchedLocation.startsWith("/login");

        if (isLoggedIn) {
        } else if (!isLoggedIn) {
          // if the user is not logged in, they must login
          return "/login";
        } else {
          return null;
        }

        // if the user is logged in but still on login screen, send them to the home
        if (loggingIn) {
          return "/";
        }

        return null;
      },
      refreshListenable: _GoRouterRefreshStream(
        authRepository.user,
      ));
}

class _GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();

    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
