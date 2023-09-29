import 'package:calculator_app/domain/fractions/src/fraction_library.dart';
import 'package:calculator_app/presentation/widgets/calculator_display.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/infrastructure/arithmethic_expressions/src/arithmetic_expressions_library.dart'
    as expressions;
import 'package:calculator_app/presentation/widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final expressionsLibrary = expressions.ExpressionCalculator();
  String smallScreen = '';
  String smallScreenGlyph = '';
  String bigScreen = '';
  bool operatorClicked = false;
  bool equalClicked = false;
  bool fractionResult = false;
  bool fractionValue = false;
  num result = 0;

  void onPress(String text) {
    setState(() {
      switch (text) {
        case 'AC':
          smallScreen = '';
          bigScreen = '0';
          operatorClicked = false;
          equalClicked = false;
          fractionValue = false;
          break;
        case 'backspace':
          if (bigScreen == '0') break;
          if (bigScreen.length == 1) {
            bigScreen = '0';
            operatorClicked = false;
            fractionValue = false;
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
          if (fractionValue) fractionValue = false;
          break;
        case '^':
          bigScreen = '$bigScreen^';
          if (fractionValue) fractionValue = false;
          break;
        case '=':
          try {
            String tmp = smallScreen + bigScreen;
            smallScreen = tmp;
            tmp = expressionsLibrary.extractPower(tmp);
            expressionsLibrary.createTree(tmp);
            smallScreen = '$smallScreen =';
            result = expressionsLibrary.calculate();
            bigScreen = '$result';
            operatorClicked = false;
            equalClicked = true;
          } catch (message) {
            smallScreen = '';
            bigScreen = 'Error';
          }
          break;
        case '+/-':
          if (fractionValue) {
            bigScreen = bigScreen.substring(1);
            if (bigScreen[0] == '-') {
              bigScreen = bigScreen.substring(1);
            } else {
              final tmp = '-$bigScreen';
              bigScreen = tmp;
            }
            bigScreen = '[$bigScreen';
          } else {
            if (bigScreen[0] == '-') {
              bigScreen = bigScreen.substring(1);
            } else {
              final tmp = '-$bigScreen';
              bigScreen = tmp;
            }
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
        case '[/]':
          if (bigScreen.isNotEmpty && !fractionValue) {
            if (bigScreen[0] == '(') {
              bigScreen = bigScreen.substring(1);
              bigScreen = '([$bigScreen/]';
            } else {
              bigScreen = '[$bigScreen/]';
            }
            fractionValue = true;
          }
          break;
        default:
          if (bigScreen == '0' || operatorClicked) {
            bigScreen = text;
            operatorClicked = false;
          } else if (equalClicked) {
            equalClicked = false;
            smallScreen = '';
            bigScreen = text;
          } else if (fractionValue) {
            if (text == ')') {
              bigScreen = '$bigScreen)';
            } else {
              String tmp = bigScreen.substring(0, bigScreen.length - 1);
              bigScreen = '$tmp$text]';
            }
          } else {
            bigScreen = bigScreen + text;
          }
      }
      smallScreenGlyph = smallScreen.replaceAll('[', '').replaceAll(']', '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        CalculatorDisplay(
            text: smallScreenGlyph, fontSize: 30, height: 40, glyph: true),
        const SizedBox(
          height: 15,
        ),
        CalculatorDisplay(text: bigScreen, fontSize: 70, height: 100),
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
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress('SD'),
                  ),
                  CalculatorBtn(
                    icon: Icons.backspace_rounded,
                    backgroundColor: Colors.grey,
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
                    text: '[/]',
                    backgroundColor: const Color(0xff9C0D38),
                    onPressed: () => onPress('[/]'),
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
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress("7"),
                  ),
                  CalculatorBtn(
                    text: "8",
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress("8"),
                  ),
                  CalculatorBtn(
                    text: "9",
                    backgroundColor: Colors.grey,
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
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress("4"),
                  ),
                  CalculatorBtn(
                    text: "5",
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress("5"),
                  ),
                  CalculatorBtn(
                    text: "6",
                    backgroundColor: Colors.grey,
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
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress("1"),
                  ),
                  CalculatorBtn(
                    text: "2",
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress("2"),
                  ),
                  CalculatorBtn(
                    text: "3",
                    backgroundColor: Colors.grey,
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
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress("+/-"),
                  ),
                  CalculatorBtn(
                    text: "0",
                    backgroundColor: Colors.grey,
                    onPressed: () => onPress("0"),
                  ),
                  CalculatorBtn(
                    text: ".",
                    backgroundColor: Colors.grey,
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
