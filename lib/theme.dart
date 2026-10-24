import 'package:flutter/material.dart';

class AppColors {
  static const Color cream = Color(0xFFFFF8F0);
  static const Color brown = Color(0xFF6F4E37);
  static const Color dark = Color(0xFF2B1B12);
  static const Color accent = Color(0xFFD98E04);
  static const Color grey = Color(0xFF9C8B80);
}

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.cream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brown,
      primary: AppColors.brown,
      secondary: AppColors.accent,
    ),
  );
}
