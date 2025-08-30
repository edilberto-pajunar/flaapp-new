import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/admin/layout/features/levels/view/admin_levels_page.dart';
import 'package:flaapp/features/auth/view/auth_page.dart';
import 'package:flaapp/features/level/view/level_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WrapperView extends StatefulWidget {
  const WrapperView({super.key});

  @override
  State<WrapperView> createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView> {
  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(AppInitRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (prev, curr) => prev.currentUserInfo != curr.currentUserInfo,
      listener: (context, state) {
        if (state.currentUserInfo == null) {
          context.goNamed(AuthPage.route);
        } else {
          if (state.currentUserInfo?.role == "admin") {
            context.goNamed(AdminLevelsPage.route);
          } else {
            context.goNamed(LevelPage.route);
          }
        }
      },
      builder: (context, state) {
        return Scaffold();
      },
    );
  }
}
