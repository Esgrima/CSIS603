import 'dart:io';
import 'package:path/path.dart' as path;

/// Utility class that prints the directory structure to standard output
/// showing the composition of nested files and subdirectories.
class PrintDirectoryStructure {
  static var _nestingLevel = 0;

  //In Dart, FileSystemEntity is the super class to File, Directory, and Link
  static void printTree(FileSystemEntity entity) {
    if (FileSystemEntity.isDirectorySync(entity.path)) {
      _printDirectory(entity, _nestingLevel);
      _nestingLevel++;

      (entity as Directory).listSync().forEach((entity) => printTree(entity));

      _nestingLevel--;
    } else if (FileSystemEntity.isFileSync(entity.path)) {
      _nestingLevel++;

      _printFile(entity, _nestingLevel);

      _nestingLevel--;
    }
  }

  static void _printDirectory(FileSystemEntity entity, int nestingLevel) {
    stdout.writeln(_getEntityName(entity, nestingLevel, '+'));
  }

  static void _printFile(FileSystemEntity entity, int nestingLevel) {
    stdout.writeln(_getEntityName(entity, nestingLevel, '-'));
  }

  static String _getEntityName(
      FileSystemEntity entity, int nestingLevel, String symbol) {
    var indent = _getIndentString(nestingLevel);
    return '${indent}${symbol} ${path.basename(entity.path)}';
  }

  static String _getIndentString(int nestingLevel) {
    var s = StringBuffer();

    for (var i = 0; i < nestingLevel; i++) {
      s.write('   ');
    }

    return s.toString();
  }

  static void printUsage() {
    stdout.writeln(
        'Usage: dart edu.citadel.util.PrintDirectoryStructure(<path>)');
    stdout.writeln('       where <path> is the path of a file or directory');
    stdout.writeln();
  }
}
