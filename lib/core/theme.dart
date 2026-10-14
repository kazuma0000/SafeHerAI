import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFCE5B7A), brightness: Brightness.light), scaffoldBackgroundColor: const Color(0xFFFFFBFC), inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder(), filled: true, fillColor: Colors.white), cardTheme: const CardThemeData(margin: EdgeInsets.zero, elevation: 0));
}
