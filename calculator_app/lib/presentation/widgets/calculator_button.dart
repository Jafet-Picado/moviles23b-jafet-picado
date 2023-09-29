import 'package:flutter/material.dart';

class CalculatorBtn extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const CalculatorBtn(
      {this.icon,
      this.text = '',
      required this.backgroundColor,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      radius: 20,
      child: Container(
        height: 58,
        width: 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: (icon != null)
            ? Icon(icon, size: 30, color: Colors.white)
            : Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25)),
      ),
    );
  }
}