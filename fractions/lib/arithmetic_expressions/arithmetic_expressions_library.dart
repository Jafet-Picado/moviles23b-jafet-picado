library arithmethic_expressions_calculator;

import 'package:fractions/fraction/fraction_library.dart';

class Node {
  dynamic value;
  Node? left;
  Node? right;

  Node(this.value, [this.left, this.right]);
}

class ExpressionCalculator {
  Node? root;

  void createTree(String expression) {
    final stack = <Node>[];
    final output = <Node>[];

    final tokens = expression.split(' ');

    for (final token in tokens) {
      if (token.startsWith('[') && token.endsWith(']')) {
        final fraction = token.substring(1, token.length - 1);
        final node = Node(Fraction.fromString(fraction));
        output.add(node);
      } else if (isNumeric(token)) {
        final node = Node(token);
        output.add(node);
      } else if (token == '(') {
        stack.add(Node(token));
      } else if (token == ')') {
        while (stack.isNotEmpty && stack.last.value != '(') {
          final operation = stack.removeLast();
          final b = stack.removeLast();
          final a = stack.removeLast();
          operation.left = a;
          operation.right = b;
          output.add(operation);
        }
        stack.removeLast();
      } else {
        while (stack.isNotEmpty &&
            getPrecedence(token) <= getPrecedence(stack.last.value)) {
          final operator = stack.removeLast();
          final b = output.removeLast();
          final a = output.removeLast();
          operator.left = a;
          operator.right = b;
          output.add(operator);
        }
        stack.add(Node(token));
      }

      while (stack.isNotEmpty) {
        final operator = stack.removeLast();
        final b = output.removeLast();
        final a = output.removeLast();
        operator.left = a;
        operator.right = b;
        output.add(operator);
      }

      root = output.first;
    }
  }

  int getPrecedence(String operator) {
    switch (operator) {
      case '+':
      case '-':
        return 1;
      case '*':
      case '/':
        return 2;
      default:
        return 0;
    }
  }

  Fraction calculate() {
    return Fraction(1, 1);
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  String infixToPrefix() {
    return '';
  }
}
