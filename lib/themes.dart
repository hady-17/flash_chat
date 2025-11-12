import 'package:flutter/material.dart';

class AppTheme {
  static const Color seed = Colors.lightBlueAccent;

  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
  );

  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
  );

  static ThemeData get lightTheme => ThemeData(
    colorScheme: _lightScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: _lightScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightScheme.primary,
      foregroundColor: _lightScheme.onPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      hintStyle: TextStyle(color: _lightScheme.onSurface.withOpacity(0.6)),
      border: InputBorder.none,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: _lightScheme.primary),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    colorScheme: _darkScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: _darkScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkScheme.primary,
      foregroundColor: _darkScheme.onPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      hintStyle: TextStyle(color: _darkScheme.onSurface.withOpacity(0.6)),
      border: InputBorder.none,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: _darkScheme.primary),
    ),
  );
}
