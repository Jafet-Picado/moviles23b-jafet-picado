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
    buffer.write(node.value + ' ');
    preorder(node.left, buffer);
    preorder(node.right, buffer);
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
      }
    }
  }

  Fraction calculate() {
    return Fraction(1, 1);
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
