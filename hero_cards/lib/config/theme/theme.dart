import 'package:flutter/material.dart';

//Tema personalizado de la aplicación
class AppTheme {
  ThemeData getAppTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xFFB118C8),
      useMaterial3: true,
    );
  }
}
