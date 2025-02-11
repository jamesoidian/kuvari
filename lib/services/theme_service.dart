import 'package:flutter/material.dart';

class ThemeService {
  static AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: Colors.teal,
    foregroundColor: Colors.white,
    shadowColor: Colors.tealAccent,
    elevation: 6.0,
    surfaceTintColor: Colors.teal.shade700,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16.0),
      ),
    ),
  );

  static Gradient get appBarGradient => LinearGradient(
    colors: [Colors.teal, Colors.teal.shade700],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: Colors.teal,
    foregroundColor: Colors.white,
  );

  static Color get primaryColor => Colors.teal;
  static Color get secondaryColor => Colors.tealAccent;
}
