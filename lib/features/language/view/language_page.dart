import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/language/bloc/language_bloc.dart';
import 'package:flaapp/features/language/view/language_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePage extends StatelessWidget {
  static String route = "language_page_route";
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<LanguageBloc>(),
      child: LanguageView(),
    );
  }
}
