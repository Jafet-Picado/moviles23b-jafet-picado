import 'package:fractions/arithmetic_expressions/src/arithmetic_expressions_library.dart';

void main(List<String> arguments) {
  final exp = ExpressionCalculator();
  exp.createTree('([6/3] + 5) - -3');
  print(exp.calculate(2));
}
