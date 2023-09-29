import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String text;
  final double fontSize;
  final double height;

  const CalculatorDisplay(
      {this.text = '',
      required this.fontSize,
      required this.height,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        height: height,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
