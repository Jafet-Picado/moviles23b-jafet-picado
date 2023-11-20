import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getAppTheme() => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.purple,
        useMaterial3: true,
      );
}
