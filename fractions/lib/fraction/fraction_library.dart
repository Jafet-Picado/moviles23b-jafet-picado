library fraction;

class Fraction {
  int? numerator;
  int? denominator;

  Fraction(this.numerator, this.denominator) {
    if (denominator == 0) {
      throw ArgumentError('Denominator cannot be 0');
    }
    simplify();
  }

  Fraction.fromJson(Map<String, int?> fraction) {
    numerator = fraction['numerator'];
    denominator = fraction['denominator'];
    simplify();
  }

  Fraction.fromString(String fraction) {
    List<String> numbers = fraction.split('/');
    if (numbers.length != 2) {
      throw Exception('There are less or more than 2 numbers');
    }

    numerator = int.parse(numbers[0]);
    denominator = int.parse(numbers[1]);
    simplify();
  }

  Fraction.fromDouble(double value) {
    double epsilon = 1.0e-10;
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError("Invalid input: $value");
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

  int _gcd(int a, int b) {
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  void simplify() {
    if (denominator == 0) {
      throw Exception('The denominator may be 0');
    }

    int gcd = _gcd(numerator!, denominator!);

    numerator = numerator! ~/ gcd;
    denominator = denominator! ~/ gcd;
  }

  Fraction operator +(Fraction other) {
    int newNumerator =
        (numerator! * other.denominator!) + (other.numerator! * denominator!);
    int newDenominator = denominator! * other.denominator!;
    final result = Fraction(newNumerator, newDenominator);
    result.simplify();
    return result;
  }

  Fraction operator -(Fraction other) {
    int newNumerator =
        numerator! * other.denominator! - other.numerator! * denominator!;
    int newDenominator = denominator! * other.denominator!;
    final result = Fraction(newNumerator, newDenominator);
    result.simplify();
    return result;
  }

  Fraction operator *(Fraction other) {
    int newNumerator = numerator! * other.numerator!;
    int newDenominator = denominator! * other.denominator!;
    final result = Fraction(newNumerator, newDenominator);
    result.simplify();
    return result;
  }

  Fraction operator /(Fraction other) {
    int newNumerator = numerator! * other.denominator!;
    int newDenominator = denominator! * other.numerator!;
    final result = Fraction(newNumerator, newDenominator);
    result.simplify();
    return result;
  }

  bool operator <(Fraction other) {
    return toNum() < other.toNum();
  }

  bool operator <=(Fraction other) {
    return toNum() <= other.toNum();
  }

  bool operator >(Fraction other) {
    return toNum() > other.toNum();
  }

  bool operator >=(Fraction other) {
    return toNum() >= other.toNum();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fraction &&
        runtimeType == other.runtimeType &&
        numerator == other.numerator &&
        denominator == other.denominator;
  }

  @override
  int get hashCode => numerator.hashCode ^ denominator.hashCode;

  num toNum() {
    return numerator! / denominator!;
  }

  @override
  String toString() {
    return denominator == 1 ? '$numerator' : '$numerator/$denominator';
  }
}

extension IntToFraction on int {
  Fraction toFraction() {
    return Fraction(this, 1);
  }
}

extension StringToFraction on String {
  Fraction toFraction() {
    return Fraction.fromString(this);
  }
}

extension DoubleToFraction on double {
  Fraction toFraction() {
    return Fraction.fromDouble(this);
  }
}
