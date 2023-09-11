library arithmethic_expressions_calculator;

import 'dart:collection';

import 'package:fractions/fraction/fraction_library.dart';

class Node {
  dynamic value;
  Node? left;
  Node? right;

  Node(this.value, [this.left, this.right]);

  String preorderRoute() {
    final buffer = StringBuffer();
    preorder(this, buffer);
    return buffer.toString();
  }

  void preorder(Node? node, StringBuffer buffer) {
    if (node == null) return;
    buffer.write('${node.value.toString().replaceAll(RegExp(r'\.0$'), '')} ');
    preorder(node.left, buffer);
    preorder(node.right, buffer);
  }

  dynamic calculate() {
    if (value is int || value is double) {
      return value;
    } else if (value is Fraction) {
      Fraction tmp = value;
      return tmp.toNum();
    } else if (value is String) {
      switch (value) {
        case '+':
          return left!.calculate() + right!.calculate();
        case '-':
          return left!.calculate() - right!.calculate();
        case '/':
          return left!.calculate() / right!.calculate();
        case '*':
          return left!.calculate() * right!.calculate();
        default:
          throw ArgumentError('Invalid operator: $value');
      }
    }
  }
}

class ExpressionCalculator {
  Node? root;

  static final Map<String, int> _precedence = {
    '+': 1,
    '-': 1,
    '*': 2,
    '/': 2,
  };

  static final _operators = _precedence.keys.toSet();

  void createTree(String expression) {
    final outputQueue = Queue<Node>();
    final operatorStack = Queue<String>();

    List<String> tokens = _tokenize(expression);

    for (String token in tokens) {
      if (_isNumeric(token)) {
        outputQueue.add(Node(_parseOperand(token)));
      } else if (_operators.contains(token)) {
        while (operatorStack.isNotEmpty &&
            operatorStack.last != '(' &&
            _precedence[token]! <= _precedence[operatorStack.last]!) {
          final operator = operatorStack.removeLast();
          final right = outputQueue.removeLast();
          final left = outputQueue.removeLast();
          outputQueue.add(Node(operator)
            ..left = left
            ..right = right);
        }
        operatorStack.add(token);
      } else if (token == '(') {
        operatorStack.add(token);
      } else if (token == ')') {
        while (operatorStack.isNotEmpty && operatorStack.last != '(') {
          final operator = operatorStack.removeLast();
          final right = outputQueue.removeLast();
          final left = outputQueue.removeLast();
          outputQueue.add(Node(operator)
            ..left = left
            ..right = right);
        }
        operatorStack.removeLast();
      }
    }
    while (operatorStack.isNotEmpty) {
      final operator = operatorStack.removeLast();
      final right = outputQueue.removeLast();
      final left = outputQueue.removeLast();
      outputQueue.add(Node(operator)
        ..left = left
        ..right = right);
    }

    if (outputQueue.isEmpty) {
      throw ArgumentError('Invalid expression: $expression');
    }

    root = outputQueue.first;
  }

  num calculate() {
    return root!.calculate();
  }

  List<String> _tokenize(String expression) {
    final pattern = RegExp(r"(\d+\.\d+|\d+|\[.*?\]|\+|\-|\*|\/|\(|\))|(\s+)");
    final matches = pattern.allMatches(expression);
    final tokens =
        matches.map((match) => match.group(1)).whereType<String>().toList();
    return tokens;
  }

  bool _isNumeric(String value) {
    return double.tryParse(value) != null || value.startsWith('[');
  }

  dynamic _parseOperand(String token) {
    if (token.startsWith('[')) {
      final fraction = token.substring(1, token.length - 1);
      return Fraction.fromString(fraction);
    } else {
      return double.parse(token);
    }
  }

  String getPreorderRoute() {
    return root!.preorderRoute();
  }
}
