library fraction;

import 'dart:math' as math;

class Fraction {
  late int numerator;
  late int denominator;
  late int precision;

  /// Basic constructor that receives int values
  Fraction(this.numerator, this.denominator, [this.precision = 2]) {
    if (denominator == 0) {
      throw ArgumentError('Denominator cannot be 0');
    }
    simplify();
  }

  /// Named constructor to create a Fraction with a JSON as parameter
  Fraction.fromJson(Map<String, int> fraction, [this.precision = 2]) {
    if (!fraction.containsKey('numerator') ||
        !fraction.containsKey('denominator')) {
      throw ArgumentError("Invalid JSON format.");
    }

    numerator = fraction['numerator'] ?? 0;
    denominator = fraction['denominator'] ?? 1;

    if (denominator == 0) {
      throw ArgumentError("Denominator cannot be zero.");
    }

    simplify();
  }

  /// Named constructor to create a Fraction with a String
  Fraction.fromString(String fraction, [this.precision = 2]) {
    List<String> numbers = fraction.split('/');
    if (numbers.length != 2) {
      throw Exception('There are less or more than 2 numbers');
    }
    if (int.parse(numbers[1]) == 0) {
      throw ArgumentError('Denominator cannot be 0');
    }
    if (!isNumeric(numbers[0]) || !isNumeric(numbers[1])) {
      throw ArgumentError('The fraction cannot have letters in it');
    }

    numerator = int.parse(numbers[0]);
    denominator = int.parse(numbers[1]);
    simplify();
  }

  /// Named constructor to create a Fraction with a double value
  Fraction.fromDouble(double value, [this.precision = 2]) {
    double epsilon = 1.0e-10;
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError("Invalid input");
    }

    int sign = value < 0 ? -1 : 1;
    value = value.abs();

    int n = 1;
    int d = 1;
    double approx = n / d;

    while ((approx - value).abs() > epsilon) {
      if (approx < value) {
        n++;
      } else {
        d++;
      }
      approx = n / d;
    }

    final gcdValue = _gcd(n, d);
    numerator = sign * (n ~/ gcdValue);
    denominator = d ~/ gcdValue;
  }

  /// Returns the greatest common divisor
  int _gcd(int a, int b) {
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  /// Simplifies the numerator and denominator of a Fraction
  void simplify() {
    int gcd = _gcd(numerator, denominator);

    numerator = numerator ~/ gcd;
    denominator = denominator ~/ gcd;
  }

  /// Return true if a string has only numeric values (Except the minus symbol)
  bool isNumeric(String fraction) {
    final RegExp numericRegex = RegExp(r'^-?\d+$');
    return numericRegex.hasMatch(fraction);
  }

  /// Plus operator overload method
  Fraction operator +(Fraction other) {
    int newNumerator =
        (numerator * other.denominator) + (other.numerator * denominator);
    int newDenominator = denominator * other.denominator;
    final result = Fraction(newNumerator, newDenominator);
    result.simplify();
    return result;
  }

  /// Minus operator overload method
  Fraction operator -(Fraction other) {
    int newNumerator =
        numerator * other.denominator - other.numerator * denominator;
    int newDenominator = denominator * other.denominator;
    final result = Fraction(newNumerator, newDenominator);
    result.simplify();
    return result;
  }

  /// Multiplication operator overload method
  Fraction operator *(Fraction other) {
    int newNumerator = numerator * other.numerator;
    int newDenominator = denominator * other.denominator;
    final result = Fraction(newNumerator, newDenominator);
    result.simplify();
    return result;
  }

  /// Division operator overload method
  Fraction operator /(Fraction other) {
    int newNumerator = numerator * other.denominator;
    int newDenominator = denominator * other.numerator;
    final result = Fraction(newNumerator, newDenominator);
    result.simplify();
    return result;
  }

  /// Less than operator overload method
  bool operator <(Fraction other) {
    return toNum() < other.toNum();
  }

  /// Less than or equal operator overload method
  bool operator <=(Fraction other) {
    return toNum() <= other.toNum();
  }

  /// Greater than operator overload method
  bool operator >(Fraction other) {
    return toNum() > other.toNum();
  }

  /// Greater than or equal operator overload method
  bool operator >=(Fraction other) {
    return toNum() >= other.toNum();
  }

  /// Equal operator overload method
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fraction &&
        runtimeType == other.runtimeType &&
        numerator == other.numerator &&
        denominator == other.denominator;
  }

  /// Override the get hashCode to overload the equal operator
  @override
  int get hashCode => numerator.hashCode ^ denominator.hashCode;

  /// Return the a Fraction pow based on the exponent
  /// (Accepts negative exponents)
  Fraction pow(int exponent) {
    if (exponent == 0) {
      return Fraction(1, 1);
    }

    if (exponent < 0) {
      return Fraction(denominator, numerator).pow(-exponent);
    }

    Fraction result = this;
    for (int index = 1; index < exponent; index++) {
      result *= this;
    }
    return result;
  }

  /// Getter that returns true if a Fraction is proper
  bool get isProper => numerator < denominator;

  /// Getter that returns true if a Fraction is improper
  bool get isImproper => numerator >= denominator;

  /// Getter that returns true if a Fraction is whole
  bool get isWhole => numerator % denominator == 0;

  /// Getter that returns the Fraction as a num value
  num toNum() {
    final result = numerator / denominator;
    num multiplier = math.pow(10.0, precision);
    return (result * multiplier).round() / multiplier;
  }

  /// toString override method to return the Fraction as an String
  @override
  String toString() {
    return denominator == 1 ? '$numerator' : '$numerator/$denominator';
  }
}

/// int type extension to add a method to create a Fraction with an int
extension IntToFraction on int {
  Fraction toFraction() {
    return Fraction(this, 1);
  }
}

/// String type extension to add a method to create a Fraction with a String
extension StringToFraction on String {
  Fraction toFraction() {
    return Fraction.fromString(this);
  }
}

/// double type extension to add a method to create a Fraction with an double
extension DoubleToFraction on double {
  Fraction toFraction() {
    return Fraction.fromDouble(this);
  }
}
