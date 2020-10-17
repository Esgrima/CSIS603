package edu.citadel.cs;

import static java.nio.file.FileVisitResult.CONTINUE;

import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;

public class PrintDirectoryStructureFileVisitor extends SimpleFileVisitor<Path> {

  private int nesting_level = 0;

  /**
   * Prints the structure for the file whose path name is given in arg[0].
   */
  public static void main(String[] args) throws IOException {
    if (args.length != 1) {
      PrintDirectoryStructure.printUsage();
      System.exit(-1);
    }

    String pathName = args[0];
    Path file = Paths.get(pathName);

    if (file.toFile().exists()) {
      PrintDirectoryStructureFileVisitor visitor = new PrintDirectoryStructureFileVisitor();
      PrintDirectoryStructure.printTree(file, visitor);
    } else {
      System.out.println("*** File " + pathName + " does not exist. ***");
    }
  }


  /**
   * Invoked for a directory before entries in the directory are visited.
   *
   * <p> If this method returns {@link FileVisitResult#CONTINUE CONTINUE},
   * then entries in the directory are visited. If this method returns {@link
   * FileVisitResult#SKIP_SUBTREE SKIP_SUBTREE} or {@link FileVisitResult#SKIP_SIBLINGS
   * SKIP_SIBLINGS} then entries in the directory (and any descendants) will not be visited.
   *
   * @param dir   a reference to the directory
   * @param attrs the directory's basic attributes
   * @return the visit result
   * @throws IOException if an I/O error occurs
   */
  @Override
  public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {
    // Directory is printed before entering and printing its Files
    PrintDirectoryStructure.printDirectory(dir, nesting_level);
    nesting_level++;

    return CONTINUE;
  }

  /**
   * Invoked for a file in a directory.
   *
   * @param file  a reference to the file
   * @param attrs the file's basic attributes
   * @return the visit result
   * @throws IOException if an I/O error occurs
   */
  @Override
  public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
    nesting_level++;
    PrintDirectoryStructure.printFile(file, nesting_level);
    nesting_level--;

    return CONTINUE;
  }


  /**
   * Invoked for a directory after entries in the directory, and all of their descendants, have been
   * visited. This method is also invoked when iteration of the directory completes prematurely (by
   * a {@link #visitFile visitFile} method returning {@link FileVisitResult#SKIP_SIBLINGS
   * SKIP_SIBLINGS}, or an I/O error when iterating over the directory).
   *
   * @param dir a reference to the directory
   * @param exc {@code null} if the iteration of the directory completes without an error; otherwise
   *            the I/O exception that caused the iteration of the directory to complete
   *            prematurely
   * @return the visit result
   * @throws IOException if an I/O error occurs
   */
  @Override
  public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException {
    nesting_level--;

    return CONTINUE;
  }
}
