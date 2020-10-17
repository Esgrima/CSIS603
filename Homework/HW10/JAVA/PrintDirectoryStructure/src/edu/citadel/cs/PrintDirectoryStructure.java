package edu.citadel.cs;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;


/**
 * Utility class that prints the directory structure to standard output showing the composition of
 * nested files and subdirectories.
 */
public class PrintDirectoryStructure {

  private static final String DIRECTORY_SYMBOL = "+";
  private static final String FILE_SYMBOL = "-";

  public static void printTree(Path file, PrintDirectoryStructureFileVisitor visitor)
      throws IOException {
    Files.walkFileTree(file, visitor);
  }

  protected static void printDirectory(Path dir, int nestingLevel) {
    System.out.println(toString(dir, nestingLevel, DIRECTORY_SYMBOL));
  }


  protected static void printFile(Path file, int nestingLevel) {
    System.out.println(toString(file, nestingLevel, FILE_SYMBOL));
  }

  private static String toString(Path file, int nestingLevel, String symbol) {
    String indent = getIndentString(nestingLevel);
    return String.format("%s%s %s", indent, symbol, file.getFileName());
  }

  private static String getIndentString(int nestingLevel) {
    StringBuilder s = new StringBuilder();

    for (int i = 0; i < nestingLevel; i++) {
      s.append("   ");
    }

    return s.toString();
  }


  static void printUsage() {
    System.out.println("Usage: java edu.citadel.util.PrintDirectoryStructure(<path>)");
    System.out.println("       where <path> is the path of a file or directory");
    System.out.println();
  }
}