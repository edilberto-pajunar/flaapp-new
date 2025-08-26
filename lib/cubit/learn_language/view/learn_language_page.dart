import 'package:flaapp/cubit/learn_language/view/learn_language_view.dart';
import 'package:flutter/material.dart';

class LearnLanguagePage extends StatelessWidget {
  static const route = 'learn_language_route';
  const LearnLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LearnLanguageView();
  }
}
