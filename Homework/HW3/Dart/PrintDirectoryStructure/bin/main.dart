import 'dart:io';

import 'package:PrintDirectoryStructure/edu.citadel.util/print_directory_structure.dart';

void main(List<String> args) {
  if (args.length != 1) {
    PrintDirectoryStructure.printUsage();
    exit(-1);
  }
  FileSystemEntity file;

  var pathName = args[0];
  if (FileSystemEntity.typeSync(pathName) is File) {
    file = File(pathName);
  } else {
    file = Directory(pathName);
  }

  if (file.existsSync()) {
    PrintDirectoryStructure.printTree(file);
  } else {
    stdout.writeln('*** File ' + pathName + ' does not exist. ***');
  }
}
