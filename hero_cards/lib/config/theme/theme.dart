import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getAppTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xFFB118C8),
      useMaterial3: true,
    );
  }
}
