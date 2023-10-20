import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getAppTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFFB118C8),
      brightness: Brightness.dark,
    );
  }
}
