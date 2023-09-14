import 'package:fractions/fraction/src/fraction_library.dart';
import 'package:test/test.dart';

void main() {
  test('Constructor with int values', () {
    final tmp = Fraction(1, 2);
    expect([tmp.numerator, tmp.denominator], [1, 2]);
  });

  test('Constructor with int and simplification', () {
    final tmp = Fraction(2, 4);
    expect([tmp.numerator, tmp.denominator], [1, 2]);
  });

  test('Constructor with int using denominator 0', () {
    expect(() => Fraction(1, 0), throwsA(isArgumentError));
  });

  test('Create a Fraction with Json', () {
    final tmp = Fraction.fromJson({"numerator": 1, "denominator": 2});
    expect([tmp.numerator, tmp.denominator], [1, 2]);
  });

  test('Create a Fraction with Json using denominator 0', () {
    expect(() => Fraction.fromJson({"numerator": 1, "denominator": 0}),
        throwsA(isArgumentError));
  });

  test('Create a Fraction with invalid Json format', () {
    expect(() => Fraction.fromJson({"number": 1, "denominator": 0}),
        throwsA(isArgumentError));
  });

  test('Create a Fraction with String', () {
    final tmp = Fraction.fromString("1/2");
    expect([tmp.numerator, tmp.denominator], [1, 2]);
  });

  test('Create a Fraction with String using denominator 0', () {
    expect(() => Fraction.fromString("1/0"), throwsA(isArgumentError));
  });

  test('Create a Fraction with String using letters', () {
    expect(() => Fraction.fromString("a/2"), throwsA(isArgumentError));
  });

  test('Create a Fraction with String using negative numbers', () {
    final a = Fraction.fromString("-1/2");
    final b = Fraction.fromString("1/-2");
    expect([a.numerator, a.denominator], [-1, 2]);
    expect([b.numerator, b.denominator], [1, -2]);
  });

  test('Create a Fraction with String using an invalid format', () {
    expect(() => Fraction.fromString("25"), throwsA(isArgumentError));
  });

  test('Create a Fraction with Double', () {
    final tmp = Fraction.fromDouble(0.50);
    expect([tmp.numerator, tmp.denominator], [1, 2]);
  });

  test('Create a Fraction with a Double and compare num values', () {
    expect(Fraction.fromDouble(0.50).toNum(), 0.50);
  });

  test('Create a Fraction with a Double with NaN value', () {
    expect(() => Fraction.fromDouble(double.nan), throwsA(isArgumentError));
  });

  test('Create a Fraction with a Double with infinite value', () {
    expect(
        () => Fraction.fromDouble(double.infinity), throwsA(isArgumentError));
  });

  /// "123" returns true
  /// "-123" returns true
  /// "1a2" returns false
  /// "aaa" returns false
  /// "-12a" returns false
  test('String isNumeric verification', () {
    final tmp = Fraction(1, 1);
    expect(tmp.isNumeric("123"), true);
    expect(tmp.isNumeric("-123"), true);
    expect(tmp.isNumeric("1a3"), false);
    expect(tmp.isNumeric("aaa"), false);
    expect(tmp.isNumeric("-12a"), false);
  });

  test('Operations between Fractions', () {
    Fraction a = Fraction(1, 2);
    Fraction b = Fraction(8, 4);
    Fraction sum = a + b;
    Fraction subs = a - b;
    Fraction division = a / b;
    Fraction multi = a * b;
    expect(sum.toNum(), 2.5);
    expect(subs.toNum(), -1.5);
    expect(division.toNum(), 0.25);
    expect(multi.toNum(), 1);
  });

  test('Comparation operators between Fractions', () {
    Fraction a = Fraction(1, 2);
    Fraction b = Fraction(8, 4);
    Fraction c = Fraction(8, 4);
    expect(a < b, true);
    expect(a > b, false);
    expect(b > a, true);
    expect(a <= b, true);
    expect(b <= c, true);
    expect(b >= a, true);
    expect(b >= c, true);
    expect(c == b, true);
    expect(a == b, false);
  });

  test('Fraction pow operation', () {
    Fraction tmp = Fraction(1, 3);
    Fraction powPositive =
        Fraction.fromDouble(tmp.pow(2).toNum().toDouble(), 2);
    Fraction powNegative =
        Fraction.fromDouble(tmp.pow(-2).toNum().toDouble(), 2);
    Fraction powZero = Fraction.fromDouble(tmp.pow(0).toNum().toDouble(), 2);
    expect([powPositive.toNum(), powNegative.toNum(), powZero.toNum()],
        [0.11, 9.0, 1.0]);
  });

  test('Proper, Improper or Whole Fraction verification', () {
    final a = Fraction(1, 3);
    final b = Fraction(4, 2);
    final c = Fraction(4, 4);
    expect([
      a.isProper,
      a.isImproper,
      b.isProper,
      b.isImproper,
      c.isImproper,
      c.isWhole
    ], [
      true,
      false,
      false,
      true,
      true,
      true
    ]);
  });

  test('Fraction to num convertion', () {
    final tmp = Fraction(1, 2);
    expect(tmp.toNum(), 0.50);
  });

  test('Fraction toString convertion', () {
    expect(
        [Fraction(1, 2).toString(), Fraction(5, 1).toString()], ["1/2", "5"]);
  });
}
