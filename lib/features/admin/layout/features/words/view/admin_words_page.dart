import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/features/words/view/admin_words_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminWordsPage extends StatelessWidget {
  static const route = "/admin/words";
  const AdminWordsPage({
    required this.levelId,
    required this.lessonId,
    super.key,
  });

  final String levelId;
  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AdminBloc>(),
      child: AdminWordsView(
        levelId: levelId,
        lessonId: lessonId,
      ),
    );
  }
}
