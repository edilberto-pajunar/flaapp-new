import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28.0,
        color: Color(0xFF333333),
      ),
      centerTitle: true,
      scrolledUnderElevation: 0
    ),
  );
}
