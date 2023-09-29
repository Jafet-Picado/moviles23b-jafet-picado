import 'dart:ui';

import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String text;
  final double fontSize;
  final double height;
  final bool glyph;

  const CalculatorDisplay(
      {this.text = '',
      required this.fontSize,
      required this.height,
      this.glyph = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
    );

    final fractionStyle = defaultStyle.copyWith(
      fontFeatures: glyph ? const [FontFeature.fractions()] : [],
    );

    return InkResponse(
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        height: height,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RichText(
            text: TextSpan(
              children: _textCustomStyle(text, defaultStyle, fractionStyle),
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _textCustomStyle(
      String text, TextStyle defaultStyle, TextStyle fractionStyle) {
    final textSpans = <TextSpan>[];
    final pattern = RegExp(r'-?\d+/\d+');
    final matches = pattern.allMatches(text);
    int currentIndex = 0;

    for (final match in matches) {
      final fractionText = match.group(0)!;
      final start = match.start;
      final end = match.end;
      if (currentIndex < start) {
        final plainText = text.substring(currentIndex, start);
        textSpans.add(TextSpan(text: plainText, style: defaultStyle));
      }
      textSpans.add(TextSpan(text: fractionText, style: fractionStyle));
      currentIndex = end;
    }

    if (currentIndex < text.length) {
      final plainText = text.substring(currentIndex);
      textSpans.add(TextSpan(text: plainText, style: defaultStyle));
    }

    return textSpans;
  }
}
