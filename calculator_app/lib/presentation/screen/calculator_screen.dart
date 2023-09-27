import 'dart:math';

import 'package:calculator_app/domain/fractions/src/fraction_library.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/infrastructure/arithmethic_expressions/src/arithmetic_expressions_library.dart'
    as expressions;

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String smallScreen = '';
  String bigScreen = '';
  bool operatorClicked = false;
  bool equalClicked = false;
  bool fractionResult = false;
  num result = 0;

  void onPress(String text) {
    setState(() {
      switch (text) {
        case 'AC':
          smallScreen = '';
          bigScreen = '0';
          operatorClicked = false;
          equalClicked = false;
          break;
        case 'backspace':
          if (bigScreen == '0') break;
          if (bigScreen.length == 1) {
            bigScreen = '0';
            operatorClicked = false;
          } else {
            bigScreen = bigScreen.substring(0, bigScreen.length - 1);
          }
          break;
        case '+':
        case '-':
        case '*':
        case '/':
          if (!operatorClicked) {
            smallScreen = '$smallScreen$bigScreen $text ';
            operatorClicked = true;
          }
          break;
        case '^':
          bigScreen = '$bigScreen^';
          break;
        case '=':
          try {
            String tmp = smallScreen + bigScreen;
            smallScreen = tmp;
            tmp = tmp.replaceAllMapped(
                RegExp(r'(-?\d+(\.\d+)?)\^(-?\d+(\.\d+)?)'), (match) {
              double base = double.parse(match.group(1)!);
              double exponent = double.parse(match.group(3)!);
              num powerResult = pow(base, exponent);
              return powerResult.toString();
            });
            final calc = expressions.ExpressionCalculator();
            calc.createTree(tmp);
            smallScreen = '$smallScreen=';
            result = calc.calculate();
            bigScreen = '$result';
            operatorClicked = false;
            equalClicked = true;
          } catch (message) {
            smallScreen = '';
            bigScreen = 'Error';
          }
          break;
        case '+/-':
          if (bigScreen[0] == '-') {
            bigScreen = bigScreen.substring(1);
          } else {
            final tmp = '-$bigScreen';
            bigScreen = tmp;
          }
          break;
        case 'SD':
          if (equalClicked) {
            if (!fractionResult) {
              bigScreen = Fraction.fromDouble(result.toDouble()).toString();
              fractionResult = true;
            } else {
              bigScreen = '$result';
              fractionResult = false;
            }
          }
          break;
        default:
          if (bigScreen == '0' || operatorClicked) {
            bigScreen = text;
            operatorClicked = false;
          } else {
            bigScreen = bigScreen + text;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Calculadora',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
        ),
        backgroundColor: const Color(0xff9C0D38),
      ),
      body: Column(children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.black,
          height: 40,
          width: double.infinity,
          child: Text(
            smallScreen,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.black,
          height: 100,
          width: double.infinity,
          child: Text(
            bigScreen,
            style: const TextStyle(
                color: Colors.white, fontSize: 70, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalculatorBtn(
                    text: 'AC',
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress('AC'),
                  ),
                  CalculatorBtn(
                    text: 'S-D',
                    backgroundColor: Colors.white38,
                    onPressed: () => onPress('SD'),
                  ),
                  CalculatorBtn(
                    icon: Icons.backspace_rounded,
                    backgroundColor: Colors.white38,
                    onPressed: () => onPress("backspace"),
                  ),
                  CalculatorBtn(
                    text: "/",
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress('/'),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalculatorBtn(
                    text: '(',
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress('('),
                  ),
                  CalculatorBtn(
                    text: ')',
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress(')'),
                  ),
                  CalculatorBtn(
                    text: '^',
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress('^'),
                  ),
                  CalculatorBtn(
                    text: '[ ]',
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => (),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalculatorBtn(
                    text: "7",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("7"),
                  ),
                  CalculatorBtn(
                    text: "8",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("8"),
                  ),
                  CalculatorBtn(
                    text: "9",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("9"),
                  ),
                  CalculatorBtn(
                    text: "x",
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress('*'),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalculatorBtn(
                    text: "4",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("4"),
                  ),
                  CalculatorBtn(
                    text: "5",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("5"),
                  ),
                  CalculatorBtn(
                    text: "6",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("6"),
                  ),
                  CalculatorBtn(
                    text: "-",
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress('-'),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalculatorBtn(
                    text: "1",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("1"),
                  ),
                  CalculatorBtn(
                    text: "2",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("2"),
                  ),
                  CalculatorBtn(
                    text: "3",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("3"),
                  ),
                  CalculatorBtn(
                    text: "+",
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress("+"),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalculatorBtn(
                    text: "+/-",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("+/-"),
                  ),
                  CalculatorBtn(
                    text: "0",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("0"),
                  ),
                  CalculatorBtn(
                    text: ".",
                    backgroundColor: Colors.white12,
                    onPressed: () => onPress("."),
                  ),
                  CalculatorBtn(
                    text: "=",
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress("="),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

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
