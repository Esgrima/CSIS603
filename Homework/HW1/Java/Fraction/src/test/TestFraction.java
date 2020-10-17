package test;

import edu.citadel.math.Fraction;
import java.util.Scanner;

/**
 * Test class provided by instructor.
 */
public class TestFraction {

  public static void main(String[] args) {
    long numerator, denominator;
    Scanner in = new Scanner(System.in);
    Fraction f1, f2;

    do {
      System.out
          .println("Enter four integers representing two fractions (\"0 1 0 1\" to terminate):  ");

      numerator = in.nextLong();
      denominator = in.nextLong();
      f1 = new Fraction(numerator, denominator);

      numerator = in.nextLong();
      denominator = in.nextLong();
      f2 = new Fraction(numerator, denominator);

      if (!f1.equals(Fraction.ZERO) || !f2.equals(Fraction.ZERO)) {
        System.out.println("f1 = " + f1 + "    f2 = " + f2);
        System.out.println();

        System.out.println("f1.toDouble() = " + f1.toDouble()
            + "    f2.toDouble() = " + f2.toDouble());
        System.out.println();

        System.out.println("f1 == f2 is " + (f1 == f2));
        System.out.println("f1.equals(f2) is " + f1.equals(f2));
        System.out.println("f1.compareTo(f2) is " + f1.compareTo(f2));
        System.out.println();

        System.out.println("-f1 = " + f1.negate());
        System.out.println();

        System.out.println("f1 + f2 = " + f1.add(f2));
        System.out.println("f1 - f2 = " + f1.subtract(f2));
        System.out.println("f1 * f2 = " + f1.multiply(f2));
        System.out.println("f1 / f2 = " + f1.divide(f2));

        System.out.println();
      }
    }
    while (!f1.equals(Fraction.ZERO) && !f2.equals(Fraction.ZERO));
    System.out.println();

    f1 = new Fraction(5);
    f2 = new Fraction(10, 2);   // should equal f1

    if (f1.equals(f2)) {
      System.out.println("f1.equals(f2): Great!");
    } else {
      System.out.println("Error");
    }

    // Fraction f = new Fraction(6.2);      // should not be permitted; uncomment to test
    in.close();
  }
}