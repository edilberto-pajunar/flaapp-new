import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/features/lessons/view/admin_lessons_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLessonsPage extends StatelessWidget {
  static const route = "/admin_lessons";
  const AdminLessonsPage({
    required this.levelId,
    required this.levelLabel,
    super.key,
  });

  final String levelId;
  final String levelLabel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AdminBloc>(),
      child: AdminLessonsView(
        levelId: levelId,
        levelLabel: levelLabel,
      ),
    );
  }
}
