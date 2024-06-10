import 'package:flaapp/features/auth/view/auth_view.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  static String route = "auth_page_route";
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthView();
  }
}
