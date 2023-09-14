import 'package:fractions/arithmetic_expressions/src/arithmetic_expressions_library.dart';
import 'package:fractions/fraction/src/fraction_library.dart';
import 'package:test/test.dart';

void main() {
  test('Create tree with valid expression', () {
    final tmp = ExpressionCalculator();
    tmp.createTree("(2 * 3) / (2 + 1)");
    expect([tmp.root, tmp.root!.value.toString()], [isNotNull, "/"]);
  });

  test('Create tree with invalid expressions', () {
    final tmp = ExpressionCalculator();
    expect(() => tmp.createTree('2 3'), throwsA(isArgumentError));
    expect(() => tmp.createTree('(2 + 3'), throwsA(isArgumentError));
    expect(() => tmp.createTree('2 + 3)'), throwsA(isArgumentError));
  });

  test('Create tree with valid expression using Fractions', () {
    final tmp = ExpressionCalculator();
    tmp.createTree("((7 - 4) + [5/8]) * 3");
    expect([tmp.root, tmp.root!.value.toString()], [isNotNull, "*"]);
  });

  test('Tree in preorder', () {
    final tmp = ExpressionCalculator();
    tmp.createTree("(2 * 3) / (2 + 1)");
    expect(tmp.getPreorderRoute(), '/ * 2 3 + 2 1 ');
    tmp.createTree("[2/3] * (2+1) / 0.44");
    expect(tmp.getPreorderRoute(), '/ * 2/3 + 2 1 0.44 ');
    tmp.createTree('([1/6] + (2 * 9)) - 2');
    expect(tmp.getPreorderRoute(), '- + 1/6 * 2 9 2 ');
  });

  test('Verify expressions calculation', () {
    final tmp = ExpressionCalculator();
    tmp.createTree('([1/2] + (2 * 9)) - 2');
    Fraction fract = tmp.calculate(2);
    expect([tmp.calculate(), fract.toString()], [16.50, '33/2']);
  });
}
