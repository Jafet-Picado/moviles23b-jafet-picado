library fraction;

import 'dart:math' as math;

class Fraction {
  late int numerator;
  late int denominator;
  late int precision;

  /// Basic constructor that receives int values
  /// It has a precision parameter to treat the irrational numbers
  /// Also, all constructors throw an exception in case of the denominator
  /// being zero.
  /// Example: Fraction(1,3) to num is 0.33 if the precision is
  /// the default one instead of 0.33333333 because 1/3 returns an irrational
  /// number, but if the precision is changed, for example: Fraction(1, 3, 4)
  /// the result showed as num of the Fraction would be 0.3333
  Fraction(this.numerator, this.denominator, [this.precision = 2]) {
    if (denominator == 0) {
      throw ArgumentError('Denominator cannot be 0');
    }
    simplify();
  }

  /// Named constructor to create a Fraction with a JSON as parameter
  /// Example:
  /// Map<String, int> tmp = {"numerator": 2, "denominator": 4};
  /// Fraction.fromJson(tmp) would create a 2/4 Fraction.
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
  /// Example:
  /// Fraction.fromString("2/4") would create a 2/4 Fraction
  /// This constructor only accepts complete fractions, so if the String is
  /// Fraction.fromString("5") it would throw an exception because the constructor
  /// doesn't create a 5/1 Fraction unless it is explicit
  /// Also, if the String has letters o symbols in it besides the /, it also would
  /// throw an exception.
  Fraction.fromString(String fraction, [this.precision = 2]) {
    List<String> numbers = fraction.split('/');
    if (numbers.length != 2) {
      throw Exception('There are less or more than 2 values');
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
  /// Example:
  /// Fraction.fromDouble(0.50) would create a 1/2 Fraction
  /// If the value received is NaN or an Infinite value, the constructor would
  /// throw an exception.
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

  /// Returns the greatest common divisor between two numbers
  /// Example:
  /// _gcd(45, 30) returns 15
  int _gcd(int a, int b) {
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  /// Simplifies the numerator and denominator of a Fraction
  /// Example:
  /// If it is a 2/4 fraction, then after the simplification the fraction is going
  /// to be 1/2.
  void simplify() {
    int gcd = _gcd(numerator, denominator);

    numerator = numerator ~/ gcd;
    denominator = denominator ~/ gcd;
  }

  /// Return true if a string has only numeric values (Except the minus symbol)
  /// Example:
  /// "123" returns true
  /// "-123" returns true
  /// "1a2" returns false
  /// "aaa" returns false
  /// "-12a" returns false
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

  /// Return the a Fraction's pow based on the exponent
  /// (Accepts negative exponents)
  /// Example:
  /// a = Fraction(1,3)
  /// b = a.pow(2) => (1/3)^2 = 1/9
  /// c = a.pow(-2) => (1/3)^-2 = (3/1)^2 = 9
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

  /// Getter that returns true if a Fraction is proper, a fraction is proper
  /// when the denominator is greater than the numerator
  /// Example:
  /// 1/2 returns true
  /// 4/2 returns false
  /// 3/3 returns false
  bool get isProper => numerator < denominator;

  /// Getter that returns true if a Fraction is improper, a fraction is improper
  /// when the numerator is equal or greater than the denominator
  /// Example:
  /// 1/2 returns false
  /// 4/2 returns true
  /// 3/3 returns true
  bool get isImproper => numerator >= denominator;

  /// Getter that returns true if a Fraction is whole, a fraction is whole
  /// when the numerator and denominator are equal
  /// Example:
  /// 1/2 returns false
  /// 4/2 returns false
  /// 3/3 returns true
  bool get isWhole => numerator % denominator == 0;

  /// Returns the Fraction as a num value
  /// Example:
  /// Fraction(1,2).toNum() would return 0.50
  num toNum() {
    final result = numerator / denominator;
    num multiplier = math.pow(10.0, precision);
    return (result * multiplier).round() / multiplier;
  }

  /// toString override method to return the Fraction as an String
  /// Example:
  /// print(Fraction(1,2)) would print 1/2
  /// If the denominator is 1, then it would only print the numerator:
  /// print(Fraction(2,1)) would print 2
  @override
  String toString() {
    return denominator == 1 ? '$numerator' : '$numerator/$denominator';
  }
}

/// int type extension to add a method to create a Fraction with an int
/// Example:
/// 10.toFraction() would return a 10/1 Fraction
extension IntToFraction on int {
  Fraction toFraction() {
    return Fraction(this, 1);
  }
}

/// String type extension to add a method to create a Fraction with a String
/// Example:
/// "3/2".toFraction() would return a 3/2 Fraction
extension StringToFraction on String {
  Fraction toFraction() {
    return Fraction.fromString(this);
  }
}

/// double type extension to add a method to create a Fraction with an double
/// Example:
/// 0.50.toFraction() would return a 1/2 Fraction
extension DoubleToFraction on double {
  Fraction toFraction() {
    return Fraction.fromDouble(this);
  }
}
