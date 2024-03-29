import 'package:calculator_app/presentation/screens/calculator_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xff9C0D38),
          fontFamily: 'Roboto'),
      home: const CalculatorScreen(),
    );
  }
}
