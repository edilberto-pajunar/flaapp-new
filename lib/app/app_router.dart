import 'dart:async';

import 'package:flaapp/features/admin/view/admin_page.dart';
import 'package:flaapp/features/auth/view/auth_page.dart';
import 'package:flaapp/features/lesson/view/lesson_page.dart';
import 'package:flaapp/features/level/view/level_page.dart';
import 'package:flaapp/features/word/view/word_page.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';
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
          name: AdminPage.route,
          path: "/admin",
          builder: (context, state) => const AdminPage(),
        ),
        GoRoute(
          name: LevelPage.route,
          path: "/",
          builder: (context, state) => const LevelPage(),
        ),
        GoRoute(
          name: LessonPage.route,
          path: LessonPage.route,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return LessonPage(level: extra["level"] as LevelModel);
          },
        ),
        GoRoute(
          name: WordPage.route,
          path: WordPage.route,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return WordPage(
              level: extra["level"] as LevelModel,
              lesson: extra["lesson"] as LessonModel,
              lessonBloc: extra["lessonBloc"],
            );
          },
        ),
      ],
      redirect: (context, state) async {
        final currentUser = await authRepository.user.first;

        final isLoggedIn = currentUser != null;
        final loggingIn = state.matchedLocation.startsWith("/login");

        final isAdmin = currentUser?.email == "admin@gmail.com";
        print(currentUser);

        if (!isLoggedIn) {
          if (loggingIn) {
            return null;
          } else {
            return "/login";
          }
        } else {
          if (isAdmin) {
            return "/admin";
          } else {
            return "/";
          }
        }
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
