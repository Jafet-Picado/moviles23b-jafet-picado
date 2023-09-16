library arithmethic_expressions_calculator;

import 'dart:collection';

import 'package:fractions/fraction/src/fraction_library.dart';

class Node {
  /// Node's value, it can be an int, double, String or Fraction
  dynamic value;

  /// Left child of the node
  Node? left;

  /// Right child of the node
  Node? right;

  /// Node class Constructor, it receives a dynamic value (In this instance an
  /// int, double, Fraction or String) and optionally other two nodes (This
  /// forms a binary tree)
  Node(this.value, [this.left, this.right]);

  /// Returns a String with the binary tree values ordered in preorder.
  /// Example:
  /// root = *, root.left = 2 and root.right = 3 it would return "* 2 3"
  String preorderRoute() {
    final buffer = StringBuffer();
    preorder(this, buffer);
    return buffer.toString();
  }

  /// This method go through the binary tree following a preorder route
  /// (root, left subtree and then right subtree) and write the values on a
  /// StringBuffer
  void preorder(Node? node, StringBuffer buffer) {
    if (node == null) return;
    buffer.write('${node.value.toString().replaceAll(RegExp(r'\.0$'), '')} ');
    preorder(node.left, buffer);
    preorder(node.right, buffer);
  }

  /// Solves the expression by using a preorder route on the binary tree
  /// and doing the operations between the child of each operation.
  /// Example:
  /// root = *, root.left = 2 and root.right = 3
  /// The value returned would be 2 * 3 = 6
  /// But, if there is an invalid input like x instead of * to multiplication,
  /// it would throw an exception
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
  /// Root of the binary tree, mainly the last operator to use
  Node? root;

  /// Map to know the precedence of each operator to keep the correct order
  /// while solving the expression
  static final Map<String, int> _precedence = {
    '+': 1,
    '-': 1,
    '*': 2,
    '/': 2,
  };

  static final _operators = _precedence.keys.toSet();

  /// Creates the binary tree using the expression received.
  /// Example of expressions:
  /// (2 * 3) / 2 => Valid expression
  /// (2 * 3) / (2 + 1) => Valid expression
  /// (2 / (3 + 1)) => Valid expression
  /// ([2/3] + 1) => Valid expression
  /// ([2] + 1) => Invalid expression
  /// (2 + 1 => Invalid expression
  /// 2 1 => Invalid expression
  /// 2+1 => Valid expression
  /// 2 + 1 => Valid Expression
  void createTree(String expression) {
    final outputQueue = Queue<Node>();
    final operatorStack = Queue<String>();

    List<String> tokens = _tokenize(expression);
    String previousToken = '';
    int openParenthesis = 0;
    int closeParenthesis = 0;

    for (String token in tokens) {
      if (_isNumeric(token)) {
        if (_isNumeric(previousToken)) {
          throw ArgumentError('Invalid expression: $expression');
        }
        outputQueue.add(Node(_parseOperand(token)));
      } else if (_operators.contains(token)) {
        if (_operators.contains(previousToken)) {
          throw ArgumentError('Invalid expression: $expression');
        }
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
        openParenthesis++;
        operatorStack.add(token);
      } else if (token == ')') {
        closeParenthesis++;
        if (openParenthesis < closeParenthesis) {
          throw ArgumentError(
              'Unbalanced parentheses in expression: $expression');
        }
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
      previousToken = token;
    }

    if (openParenthesis != closeParenthesis) {
      throw ArgumentError('Unbalanced parentheses in expression: $expression');
    }

    while (operatorStack.isNotEmpty) {
      final operator = operatorStack.removeLast();
      final right = outputQueue.removeLast();
      final left = outputQueue.removeLast();
      outputQueue.add(Node(operator)
        ..left = left
        ..right = right);
    }

    if (outputQueue.isEmpty || operatorStack.isNotEmpty) {
      throw ArgumentError('Invalid expression: $expression');
    }

    root = outputQueue.first;
  }

  /// Calls the Node.calculate method and returns the result of the expression
  /// It has an optional parameter to return a num value or a Fraction value
  /// If the type parameter is the default one the value would be returned as num
  /// But, it the parameter is changed then the value would be returned as Fraction
  /// Example:
  /// Expression: "(1 / 2) + 0.25".
  /// Calculate with default type would return 0.75
  /// Calculate with type changed would return 3/4
  dynamic calculate([int type = 1]) {
    if (root == null) {
      throw StateError('Expression tree has not been created.');
    }
    return type == 1
        ? root!.calculate()
        : Fraction.fromDouble(root!.calculate());
  }

  /// Returns a list with all the tokens of the expression
  /// Example:
  /// "2 + 3" would return [2, +, 3]
  /// "([2/3] / 7) + 2" would return [(, [2/3], 7, ), +, 2]
  List<String> _tokenize(String expression) {
    final pattern =
        RegExp(r"(-?\d+\.\d+|-?\d+|\[.*?\]|\+|\-|\*|\/|\(|\))|(\s+)");
    final matches = pattern.allMatches(expression);
    final tokens =
        matches.map((match) => match.group(1)).whereType<String>().toList();
    return tokens;
  }

  /// Returns true if a string is a number or a Fraction
  /// Example:
  /// 2 => true
  /// 3.2 => true
  /// [2/5] => true
  /// 2a => false
  bool _isNumeric(String value) {
    return double.tryParse(value) != null || value.startsWith('[');
  }

  /// Converts or parse the token in to a double or Fraction type
  /// Example:
  /// token = "2" => returns 2.0
  /// token = "5.56" => returns 5.56
  /// token = "[2/3]" => returns a 2/3 Fraction
  dynamic _parseOperand(String token) {
    if (token.startsWith('[')) {
      final fraction = token.substring(1, token.length - 1);
      return Fraction.fromString(fraction);
    } else {
      return double.parse(token);
    }
  }

  /// Calls the Node class preorderRoute method to return a String with
  /// the binary tree preorder route
  String getPreorderRoute() {
    return root!.preorderRoute();
  }
}
