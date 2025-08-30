import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/admin/features/bloc/admin_bloc.dart';
import 'package:flaapp/admin/features/features/words/view/add_word_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAddWordPage extends StatelessWidget {
  static const route = "/admin_add_word";
  const AdminAddWordPage({
    super.key,
    required this.levelId,
    required this.lessonId,
  });

  final String levelId;
  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AdminBloc>(),
      child: AdminAddWordView(
        levelId: levelId,
        lessonId: lessonId,
      ),
    );
  }
}
