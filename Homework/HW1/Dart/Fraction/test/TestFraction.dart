import 'dart:io';

import 'package:fixnum/fixnum.dart' show Int64;
import 'package:HW1/Fraction.dart';

class TestFraction {}

void main(List<String> args) {
  Int64 numerator, denominator;
  Fraction f1, f2;

  do {
    stdout.writeln('Enter four integers representing two fractions (\'0 1 0 1\' to terminate):  ');

    numerator = Int64.parseInt(stdin.readLineSync());
    denominator = Int64.parseInt(stdin.readLineSync());
    f1 = Fraction(numerator, denominator);

    numerator = Int64.parseInt(stdin.readLineSync());
    denominator = Int64.parseInt(stdin.readLineSync());
    f2 = Fraction(numerator, denominator);

    if (!f1.equals(Fraction.ZERO) || !f2.equals(Fraction.ZERO)) {
      stdout.writeln('f1 = ${f1}      f2 = ${f2}');
      stdout.writeln();

      stdout.writeln(
          'f1.toDouble() = ${f1.toDouble()}    f2.toDouble() =  ${f2.toDouble()}');
      stdout.writeln();

      stdout.writeln('f1 == f2 is  ${(f1 == f2)}');
      stdout.writeln('f1.equals(f2) is ${f1.equals(f2)}');
      stdout.writeln('f1.compareTo(f2) is ${f1.compareTo(f2)}');
      stdout.writeln();

      stdout.writeln('-f1 = ${f1.negate()}');
      stdout.writeln();

      stdout.writeln('f1 + f2 = ${f1.add(f2)}');
      stdout.writeln('f1 - f2 = ${f1.subtract(f2)}');
      stdout.writeln('f1 * f2 = ${f1.multiply(f2)}');
      stdout.writeln('f1 / f2 = ${f1.divide(f2)}');

      stdout.writeln();
    }
  } while (!f1.equals(Fraction.ZERO) && !f2.equals(Fraction.ZERO));
  stdout.writeln();

  f1 = Fraction.wholeNumber(Int64(5));
  f2 = Fraction(Int64(10), Int64(2)); // should equal f1

  if (f1.equals(f2)) {
    stdout.writeln('f1.equals(f2): Great!');
  } else {
    stdout.writeln('Error');
  }
}
