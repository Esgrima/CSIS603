import 'dart:io';

import 'package:LinkedListIterator/edu.citadel.util/LinkedList.dart';
import 'package:test/test.dart';

void main() {
  var names;

  setUp(() async {
    names = LinkedList<String>();
  });

  tearDown(() async {});

  void _populateLinkedList(LinkedList list) {
    list.add('Rex');
    list.add('Thor');
    list.add('Iron Man');
    list.add('Hulk');
    list.add('Captain America');
  }

  group('Add/Append', () {
    test('Add to empty list', () {
      names.add('Rex');
      print(names);
      expect(names.size, 1);
      expect(names.isEmpty, isFalse);
      expect(names.indexOf('Rex'), 0);
      expect(names.getElement(0), 'Rex');
    });

    test('Add to Non Empty list', () {
      names.add('Rex');
      names.add('Thor');
      names.add('Iron Man');
      names.add('Hulk');
      names.add('Captain America');

      print(names);

      expect(names.size, 5);
      expect(names.isEmpty, isFalse);
      expect(names.indexOf('Captain America'), names.size - 1);
      expect(names.getElement(4), 'Captain America');
    });
  });

  group('Add at Index', () {
    test('below range', () {
      expect(() => names.addAtIndex(-10, 'Rex'), throwsRangeError);
    });

    test('In range', () {
      names.add('Rex');
      names.add('Thor');
      names.add('Iron Man');
      names.add('Hulk');
      names.add('Captain America');
      print(names);

      expect(names.addAtIndex(2, 'Black Widow'), null);
      expect(names.size, 6);
      expect(names.indexOf('Black Widow'), 2);
      print(names);

      expect(names.addAtIndex(5, 'Vision'), null);
      expect(names.size, 7);
      expect(names.indexOf('Vision'), 5);
      expect(names.getElement(5), 'Vision');
      print(names);
    });

    test('above range', () {
      expect(() => names.addAtIndex(names.size + 10, 'Rex'), throwsRangeError);
    });
  });

  // implemented by professor
  group('Clear', () {
    test('on Empty', () {
      expect(() => names.clear(), returnsNormally);
      expect(names.isEmpty, isTrue);
    });

    test('on Filled', () {
      names.add('Rex');
      names.add('Thor');
      names.add('Iron Man');
      names.add('Hulk');
      names.add('Captain America');
      print(names);

      expect(names.isEmpty, isFalse);
      expect(() => names.clear(), returnsNormally);
      expect(names.isEmpty, isTrue);

      print(names);
    });
  });

  // implemented by professor
  group('Get Element', () {});

  group('Set element', () {
    test('above range', () {
      expect(() => names.setElement(names.size + 10, 'Rex'), throwsRangeError);
    });

    test('below range', () {
      expect(() => names.setElement(names.size - 10, 'Rex'), throwsRangeError);
    });

    test('in range', () {
      _populateLinkedList(names);
      expect(names.setElement(3, 'Thanos'), 'Hulk');
      expect(names.indexOf('Hulk'), -1);
      expect(names.indexOf('Thanos'), 3);
    });
  });

  // implemented by professor
  group('Index of', () {});

  group('Is Empty', () {
    test('Empty Check on an empty list', () {
      expect(names.isEmpty, isTrue);
    });

    test('Empty Check on a non-empty list', () {
      names.add('Rex');
      expect(names.isEmpty, isFalse);
    });
  });

  group('Remove', () {
    test('on Empty', () {
      expect(() => names.remove(0), throwsRangeError);
    });

    test('below range', () {
      expect(() => names.remove(-10), throwsRangeError);
    });

    test('above range', () {
      expect(() => names.remove(names.size + 10), throwsRangeError);
    });

    test('on filled middle', () {
      _populateLinkedList(names);
      print(names);

      expect(names.remove(2), 'Iron Man');
      expect(names.indexOf('Iron Man'), -1);
      expect(names.size, 4);
      print(names);
    });

    test('on filled front', () {
      _populateLinkedList(names);
      print(names);

      expect(names.remove(0), 'Rex');
      expect(names.indexOf('Rex'), -1);
      expect(names.size, 4);
      print(names);
    });

    test('on filled end', () {
      _populateLinkedList(names);
      print(names);

      expect(names.remove(names.size - 1), 'Captain America');
      expect(names.indexOf('Captain America'), -1);
      expect(names.size, 4);
      print(names);
    });
  });

  group('Get Size', () {
    test('Get size on empty list', () {
      expect(names.size, 0);
    });

    test('Get size on non-empty list', () {
      for (var i = 1; i < 6; i++) {
        names.add('Rex');
        expect(names.size, i);
      }
    });
  });

  group('Iterator', () {
    test('Correct Sequence', () {
      var iteratorTest = LinkedList<String>();
      _populateLinkedList(names);
      _populateLinkedList(iteratorTest);

      print(iteratorTest);
      print(names);

      names.forEach((name) => iteratorTest.remove(iteratorTest.indexOf(name)));

      print(iteratorTest);
      print(names);
      expect(iteratorTest.isEmpty, isTrue);
    });
  });

  // implemented by professor
  group('Equals', () {});

  group('to String', () {
    test('Empty List', () {
      expect(names.toString(), '[]');
    });

    test('Filled List', () {
      var testString = '[Rex, Thor, Iron Man, Hulk, Captain America]';
      _populateLinkedList(names);
      expect(names.toString(), testString);
    });
  });

  group("Professor's Tests", () {
    test('Manual Tests', () {
      var nombres = LinkedList<String>();

      stdout.writeln(
          nombres.isEmpty ? 'The list is empty.' : 'The list is not empty.');
      stdout.writeln(nombres);
      stdout.writeln();

      _populateLinkedList(nombres);

      for (var s in nombres) {
        stdout.writeln(s);
      }
      stdout.writeln();

      // Note that you get a forEach() method for free
      // (default method in interface Iterable) that
      // allows a lambda expressions as the parameter.
      nombres.forEach((nombre) => print(nombre));
      stdout.writeln();
    });
  });
}
