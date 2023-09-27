import 'package:flutter/material.dart';
import 'package:calculator_app/infrastructure/arithmethic_expressions/src/arithmetic_expressions_library.dart'
    as expressions;

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

enum Operations { sum, sub, mult, div }

class _CalculatorScreenState extends State<CalculatorScreen> {
  String smallScreen = '';
  String bigScreen = '';

  late Operations oper;
  bool operatorAssigned = false;

  num? value1;
  num? value2;

  num result = 0;

  void onPress(String text) {
    setState(() {
      switch (text) {
        case 'AC':
          smallScreen = '';
          bigScreen = '0';
          break;
        case 'backspace':
          if (bigScreen == '0') break;
          if (bigScreen.length == 1) {
            bigScreen = '0';
          } else {
            bigScreen = bigScreen.substring(0, bigScreen.length - 1);
          }
          break;
        case '+':
          operatorAssigned = true;
          oper = Operations.sum;
          value1 = num.parse(bigScreen);
          smallScreen = '$bigScreen + ';
          break;
        case '-':
          operatorAssigned = true;
          oper = Operations.sub;
          value1 = num.parse(bigScreen);
          smallScreen = '$bigScreen - ';
          break;
        case '*':
          operatorAssigned = true;
          oper = Operations.mult;
          value1 = num.parse(bigScreen);
          smallScreen = '$bigScreen * ';
          break;
        case '/':
          operatorAssigned = true;
          oper = Operations.div;
          value1 = num.parse(bigScreen);
          smallScreen = '$bigScreen / ';
          break;
        case '=':
          value2 = num.parse(bigScreen);
          final tmp = smallScreen + value2.toString();
          final calc = expressions.ExpressionCalculator();
          calc.createTree(tmp);
          smallScreen = '$smallScreen$value2=';
          result = calc.calculate();
          bigScreen = '$result';
          operatorAssigned = false;
          break;
        case '+/-':
          if (bigScreen[0] == '-') {
            bigScreen = bigScreen.substring(1);
          } else {
            final tmp = '-$bigScreen';
            bigScreen = tmp;
          }
          break;
        default:
          if (operatorAssigned) {
            bigScreen = '0';
            operatorAssigned = false;
          }
          if (bigScreen == '0') {
            bigScreen = text;
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
                    icon: Icons.percent_rounded,
                    backgroundColor: Colors.white38,
                    onPressed: () => (),
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
        height: 70,
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: (icon != null)
            ? Icon(icon, size: 35, color: Colors.white)
            : Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30)),
      ),
    );
  }
}
