import 'package:PrintDirectoryStructure/edu.citadel.util/print_directory_structure.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('test directories', () {
    test('Professor\'s Recipe Directory', () {
      FileSystemEntity dir = Directory(
          'G:/My Drive/__CSIS603/Homework/HW3/Dart/PrintDirectoryStructure/test/edu.citadel.util/TestDirectories');

      if (dir.existsSync()) {
        expect(() => PrintDirectoryStructure.printTree(dir), returnsNormally);
      } else {
        print('fail');
      }
    });
  });
}
