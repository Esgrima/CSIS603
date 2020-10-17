library print_directory_structure;

import 'dart:io';

/// Utility class that prints the directory structure to standard output
/// showing the composition of nested files and subdirectories.
class PrintDirectoryStructure {
  /// Prints the structure for the file whose path name is given in arg[0].
  static void main(List<String> args){
    if (args.length != 1){
      _printUsage();
      exit(-1);
    }

    var pathName = args[0];
    var file = new File(pathName);

    if (file.existsSync()) {
      printTree(file);
    } else {
      stdout.writeln("*** File " + pathName + " does not exist. ***");
    }
  }


  static void printTree(File file) {
    return null;
  }


  static void _printDirectory(File dir, int nestingLevel) {
    return null;
  }


  static void _printFile(File file, int nestingLevel) {
    return null;
  }


  static String _getIndentString(int nestingLevel) {
    var s = new StringBuffer();

    for (int i = 0; i < nestingLevel; i++)
      s.write("   ");

    return s.toString();
  }


  static void _printUsage() {
    stdout.writeln(
        "Usage: dart edu.citadel.util.PrintDirectoryStructure(<path>)");
    stdout.writeln(
        "       where <path> is the path of a file or directory");
    stdout.writeln();
  }
}
