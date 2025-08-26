import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/auth/view/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WrapperView extends StatelessWidget {
  const WrapperView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (prev, curr) => prev.currentUserInfo != curr.currentUserInfo,
      listener: (context, state) {
        if (state.currentUserInfo == null) {
          context.goNamed(AuthPage.route);
        } else {
          if (state.currentUserInfo?.codeToLearn == null) {
            // context.goNamed(.route);
          } else {
            // context.goNamed(LessonPage.route);
          }
        }
      },
      builder: (context, state) {
        return Scaffold();
      },
    );
  }
}
