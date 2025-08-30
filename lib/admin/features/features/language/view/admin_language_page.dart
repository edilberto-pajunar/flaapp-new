import 'package:flaapp/admin/features/features/language/view/admin_language_view.dart';
import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/language/bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLanguagePage extends StatelessWidget {
  static const route = "/admin_language";
  const AdminLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<LanguageBloc>(),
      child: AdminLanguageView(),
    );
  }
}
