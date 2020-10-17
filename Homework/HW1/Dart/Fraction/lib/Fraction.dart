import 'package:fixnum/fixnum.dart' show Int64;

/// This class encapsulates mathematical fractions (or rational numbers).
/// Fractions have a numerator and a denominator, both of type int.
/// All fractions are normalized when they are constructed.  A normalized
/// fraction has a positive denominator and is in reduced form.  For
/// example, the fraction 2/4 is normalized to 1/2, and the fraction
/// 3/(-4) is normalized to (-3)/4.  Also, all fraction objects are
/// immutable; they cannot be changed once they have been constructed.
class Fraction implements Comparable<Fraction> {
  Int64 _numerator;
  Int64 _denominator;

  static final Fraction ZERO = Fraction.wholeNumber(Int64.ZERO);
  static final Fraction ONE = Fraction.wholeNumber(Int64.ONE);

  /// Construct a fraction with the given numerator and with a denominator of 1.
  /// @param numerator the numerator of the fraction.
  Fraction.wholeNumber(Int64 numerator) {
    _numerator = numerator;
    _denominator = Int64.ONE;
  }

  /// Constructs a fraction with the given numerator and denominator.
  /// @param  numerator    the numerator of the fraction.
  /// @param  denominator  the denominator of the fraction.
  /// @throws IllegalArgumentException  if the denominator is 0.
  Fraction(Int64 numerator, Int64 denominator) {
    if (denominator == 0) {
      throw ArgumentError.value(0, 'Fraction with zero in denominator');
    }

    // Normalize the fraction.
    if (numerator == 0) {
      denominator = Int64.ONE;
    } else {
      var divisor = _gcd(numerator, denominator);

      // ~/ is integer division in dart
      // Not sure why  numerator / divisor returns a double when it is a common
      // divisor
      numerator = numerator ~/ divisor;
      denominator = denominator ~/ divisor;

      if (denominator < 0) {
        denominator = -denominator;
        numerator = -numerator;
      }
    }

    _numerator = numerator;
    _denominator = denominator;
  }

  /// Returns the value of the fraction's numerator.
  Int64 getNumerator() => _numerator;

  /// Returns the value of the fraction's denominator.
  Int64 getDenominator() => _denominator;

  /// Returns value of the fraction converted to a double, where
  /// the numerator is divided by the denominator.
  double toDouble() {
    return _numerator.toDouble() / _denominator.toDouble();
  }

  /// Returns a new Fraction that is the result of adding the
  /// specified Fraction to this Fraction.
  ///
  /// @param f the Fraction to be added.
  Fraction add(Fraction f) {
    var numer =
        _numerator * f.getDenominator() + _denominator * f.getNumerator();
    var denom = _denominator * f.getDenominator();

    return Fraction(numer, denom);
  }

  /// Returns a new Fraction that is the result of subtracting the
  /// specified Fraction from this Fraction.
  ///
  /// @param f the Fraction to be subtracted.
  Fraction subtract(Fraction f) {
    var numer =
        _numerator * f.getDenominator() - _denominator * f.getNumerator();
    var denom = _denominator * f.getDenominator();

    return Fraction(numer, denom);
  }

  /// Returns a new Fraction that is the result of multiplying the
  /// specified Fraction with this Fraction.
  ///
  /// @param f the Fraction to be multiplied.
  Fraction multiply(Fraction f) {
    return Fraction(
        _numerator * f.getNumerator(), _denominator * f.getDenominator());
  }

  /// Returns a new Fraction that is the result of dividing this
  /// Fraction by the specified Fraction.
  ///
  /// @param f the Fraction to be used as the divisor.
  ///
  /// @throws IllegalArgumentException if the specified fraction
  ///             is Fraction(0, 1).
  Fraction divide(Fraction f) {
    if (f.getNumerator() == 0) {
      throw ArgumentError.value(
          0, 'Cannot divide fraction by Zero Fraction(0, X)');
    }

    return Fraction(
        _numerator * f.getDenominator(), _denominator * f.getNumerator());
  }

  /// Returns a new Fraction that is the result of adding 1 to this Fraction.
  Fraction inc() {
    return Fraction(_numerator + _denominator, _denominator);
  }

  /// Returns the negation of this Fraction.
  Fraction negate() {
    return Fraction(-(_numerator), _denominator);
  }

  /// Returns a string representation for the fraction of the form
  /// "n/d", where n is the numerator and d is the denominator.
  @override
  String toString() {
    return _numerator.toString() + '/' + _denominator.toString();
  }

  /// Compares this Fraction with the specified Fraction.
  ///
  /// @param   f the Fraction to be compared.
  /// @return  a negative integer, zero, or a positive integer as this
  ///          Fraction is less than, equal to, or greater than the
  ///          specified Fraction.
  @override
  int compareTo(Fraction f) {
    var compare1 = _numerator * f.getDenominator();
    var compare2 = _denominator * f.getNumerator();

    if (compare1 < compare2) {
      return -1;
    } else if (compare1 > compare2) {
      return 1;
    } else {
      return 0;
    }
  }

  // Couldn't override the hashCode function. IDE says Fraction can't define
  // hashCode( ) method and have an Object.hashCode field
  int getHashCode() {
    final prime = 31;
    var result = 1;

    result = prime * result +
        (_denominator ^ _denominator.shiftRightUnsigned(32)).toInt();
    result = prime * result +
        (_numerator ^ _numerator.shiftRightUnsigned(32)).toInt();

    return result;
  }

  bool equals(Object obj) {
    // Case 1 same object
    if (this == obj) {
      return true;
    }
    // Case 2
    else if (obj == null) {
      return false;
    }
    // Case 3 different classes
    else if (obj is! Fraction) {
      return false;
    } else {
      // Case 4 different Fraction objects with the potential of having the same values
      Fraction fraction = obj;

      return _numerator == fraction.getNumerator() &&
          _denominator == fraction.getDenominator();
    }
  }

  /// Compute the greatest common divisor of two ints.
  static Int64 _gcd(Int64 a, Int64 b) {
    var a1 = a.abs();
    var b1 = b.abs();
    Int64 temp;

    while (b1 != 0) {
      temp = a1;
      a1 = b1;
      b1 = temp % b1;
    }

    return a1;
  }
}
