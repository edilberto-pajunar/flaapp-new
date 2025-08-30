import 'package:flaapp/admin/features/bloc/admin_bloc.dart';
import 'package:flaapp/admin/features/features/lessons/view/add_admin_lesson_view.dart';
import 'package:flaapp/app/app_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdminLessonPage extends StatelessWidget {
  static const route = "/admin_add_lesson";
  const AddAdminLessonPage({
    super.key,
    required this.levelId,
  });

  final String levelId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AdminBloc>(),
      child: AddAdminLessonView(
        levelId: levelId,
      ),
    );
  }
}
