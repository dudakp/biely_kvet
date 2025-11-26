import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static CupertinoThemeData cupertinoThemeData = CupertinoThemeData(
    primaryColor: Colors.deepPurple,
    brightness: Brightness.light,
  );

  static CupertinoThemeData cupertinoDarkThemeData = CupertinoThemeData(
    primaryColor: Colors.deepPurple,
    brightness: Brightness.dark,
  );
  
  static ThemeData materialLightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  static ThemeData cupertinoDarkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
