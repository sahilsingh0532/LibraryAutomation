import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.deepPurple,
      secondary: Colors.amber,
    ),
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.deepPurple,
      secondary: Colors.amber,
    ),
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
  );
}
