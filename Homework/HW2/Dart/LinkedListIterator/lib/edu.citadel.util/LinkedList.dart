/// This class implements a List by means of a linked data structure. A List (also known as a
/// <i>sequence</i>) is an ordered collection. Elements in the list can be accessed by their integer
/// index. The index of the first element in the list is zero.
class LinkedList<E> implements Iterable<E> {
  _Node<E> _first; // reference to the first node
  _Node<E> _last; // reference to the last node
  int _size; // number of elements in the list

  /// Helper method: Checks that the specified index is between 0 and size - 1.
  ///
  /// @throws IndexOutOfBoundsException if the index is out of range (<tt>index &lt; 0 || index &gt;=
  ///                                   size()</tt>)
  void _checkIndex(int index) {
    if (index < 0 || index >= _size) {
      throw RangeError.range(index, 0, _size - 1, 'Index: ${index} is out of bounds!');
    }
  }

  /// Helper method: Find the node at a specified index.
  ///
  /// @return a reference to the node at the specified index
  /// @throws IndexOutOfBoundsException if the index is out of range (<tt>index &lt; 0 || index &gt;=
  ///                                   size()</tt>)
  _Node<E> _getNode(int index) {
    _checkIndex(index);
    var node = _first;
    for (var i = 0; i < index; ++i) {
      node = node._next;
    }
    return node;
  }

  /// Constructs an empty list.
  LinkedList() {
    _size = 0;
  }

  /// Appends the specified element to the end of the list.
  void add(E element) {
    // Empty list case
    if (isEmpty) {
      // creates a Node without a next pointer
      // assigns it to first
      _first = _Node<E>.linkLess(element);
      // first node also becomes the last node
      _last = _first;
    } // List is not empty case
    else {
      // last node points to the new node
      _last._next = _Node<E>.linkLess(element);
      // the new node becomes the last node
      _last = _last._next;
    }
    ++_size;
  }

  /// Inserts the specified element at the specified position in the list.
  ///
  /// @throws IndexOutOfBoundsException if the index is out of range (<tt>index &lt; 0 || index &gt;
  ///                                   size()</tt>)
  void addAtIndex(int index, E element) {
    _checkIndex(index);

    // empty Case
    if (isEmpty) {
      add(element);
    } else {
      var newNode = _Node<E>.linkLess(element);

      // beginning of list Case
      if (index == 0) {
        // points to the current first node
        newNode._next = _first;
        // makes the newNode the first node
        _first = newNode;
      }

      // Middle to End of list Case
      else {
        var previous = _getNode(index - 1);
        newNode._next = previous._next;
        previous._next = newNode;

        if (index == _size - 1) {
          _last = newNode;
        }
      }
    }
    ++_size;
  }

  /// Removes all of the elements from this list.
  void clear() {
    while (_first != null) {
      var temp = _first;
      _first = _first._next;
      temp._data = null;
      temp._next = null;
    }
    _last = null;
    _size = 0;
  }

  /// Returns the element at the specified position in this list.
  ///
  /// @throws IndexOutOfBoundsException if the index is out of range (<tt>index &lt; 0 || index &gt;=
  ///                                   size()</tt>)
  E getElement(int index) {
    // do not need explicit index check since getNode() does it for us
    var node = _getNode(index);
    return node.data;
  }

  /// Replaces the element at the specified position in this list with the specified element.
  ///
  /// @throws IndexOutOfBoundsException if the index is out of range (<tt>index &lt; 0 || index &gt;=
  ///                                   size()</tt>)
  /// @returns The data value previously at index
  E setElement(int index, E newValue) {
    var node = _getNode(index);
    var oldValue = node.data;
    node.data = newValue;

    return oldValue;
  }

  /// Returns the index of the first occurrence of the specified element in this list, or -1 if this
  /// list does not contain the element.
  int indexOf(Object obj) {
    var index = 0;

    var element = _Node<E>.linkLess(obj);

    if (obj == null) {
      for (var node = _first; node != null; node = node._next) {
        if (node.data == null) {
          return index;
        } else {
          index++;
        }
      }
    } else {
      for (var node = _first; node != null; node = node._next) {
        if (element.equals(node)) {
          return index;
        } else {
          index++;
        }
      }
    }
    return -1;
  }

  /// Returns <tt>true</tt> if this list contains no elements.
  @override
  bool get isEmpty => _size == 0;

  /// Removes the element at the specified position in this list. Shifts any subsequent elements to
  /// the left (subtracts one from their indices).
  ///
  /// @throws IndexOutOfBoundsException if the index is out of range (<tt>index &lt; 0 || index &gt;=
  ///                                   size()</tt>)
  /// @returns the element previously at the specified position
  E remove(int index) {
    // every case
    var removed = _getNode(index);
    var element = removed.data;

    // removing head case
    if (index == 0) {
      // Only element in the list case
      if (size == 1) {
        _first == null;
      }
      // more than one element in the list case
      else {
        _first = _getNode(1);
      }
    }
    // removing tail case
    else if (index == size - 1) {
      // set the second to last as the new last node
      _last = _getNode(index - 1);
      // next pointer to null
      // original last node will get garbage collected
      _last._next = null;
    }
    // removing in the middle case
    else {
      var previous = _getNode(index - 1);
      // Points over removed node removed's next node
      previous._next = removed._next;
    }

    --_size;
    return element;
  }

  /// Returns the number of elements in this list.
  int get size => _size;

  /// Returns an iterator over the elements in this list in proper sequence.
  @override
  Iterator<E> get iterator {
    return _LinkedListIterator(_first);
  }

  /// Returns a string representation of this list.
  @override
  String toString() {
    if (isEmpty) {
      return '[]';
    }
    var iterator = _LinkedListIterator(_first);
    var buffer = StringBuffer();
    buffer.write('[');

    while (iterator.moveNext()) {
      buffer.write('${iterator.current}');

      if (iterator.hasNext()) {
        buffer.write(', ');
      }
    }

    buffer.write(']');
    return buffer.toString();
  }

  /*
   * Compares the specified object with this list for equality. Returns true
   * if and only if both lists contain the same elements in the same order.
   */
  bool equals(Object obj) {
    if (obj == this) {
      return true;
    }

    if (obj is! LinkedList) {
      return false;
    }

    // cast obj to a linked list
    LinkedList listObj = obj;

    // compare elements in order
    var node1 = _first;
    _Node<E> node2 = listObj.first;

    //loops until a node in either list is null
    while (node1 != null && node2 != null) {
      // check to see if data values are equal
      if (node1.data == null) {
        if (node2.data != null) {
          return false;
        }
      } else {
        if (node1.equals(node2)) {
          return false;
        }
      }
      node1 = node1._next;
      node2 = node2._next;
    }
    return node1 == null && node2 == null;
  }

  /// Returns the hash code value for this list.
  @override
  int get hashCode {
    var hashCode = 1;
    var node = _first;

    while (node != null) {
      var obj = node.data;
      hashCode = 31 * hashCode + (obj == null ? 0 : obj.hashCode);
      node = node._next;
    }
    return hashCode;
  }

  /// Dart doesn't have default forEach like Java
  @override
  void forEach(void Function(E element) action) {
    if (isEmpty) return;

    var iterator = _LinkedListIterator(_first);

    while (iterator.moveNext()) {
      action(iterator.current);
    }

    // Dart's implementation
//    for (var element in this) {
//      action(element);
//    }
  }

  /// Dart's iterable interface is much larger than Java's interable interface
  @override
  bool any(bool Function(E element) test) {
    throw UnimplementedError;
  }

  @override
  Iterable<R> cast<R>() {
    throw UnimplementedError;
  }

  @override
  bool contains(Object element) {
    throw UnimplementedError;
  }

  @override
  E elementAt(int index) {
    throw UnimplementedError;
  }

  @override
  bool every(bool Function(E element) test) {
    throw UnimplementedError;
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) f) {
    throw UnimplementedError;
  }

  @override
  E get first => throw UnimplementedError;

  @override
  E firstWhere(bool Function(E element) test, {E Function() orElse}) {
    throw UnimplementedError;
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    throw UnimplementedError;
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) {
    throw UnimplementedError;
  }

  @override
  bool get isNotEmpty => throw UnimplementedError;

  @override
  String join([String separator = '']) {
    throw UnimplementedError;
  }

  @override
  E get last => throw UnimplementedError;

  @override
  E lastWhere(bool Function(E element) test, {E Function() orElse}) {
    throw UnimplementedError;
  }

  @override
  int get length => throw UnimplementedError;

  @override
  Iterable<T> map<T>(T Function(E e) f) {
    throw UnimplementedError;
  }

  @override
  E reduce(E Function(E value, E element) combine) {
    throw UnimplementedError;
  }

  @override
  E get single => throw UnimplementedError;

  @override
  E singleWhere(bool Function(E element) test, {E Function() orElse}) {
    throw UnimplementedError;
  }

  @override
  Iterable<E> skip(int count) {
    throw UnimplementedError;
  }

  @override
  Iterable<E> skipWhile(bool Function(E value) test) {
    throw UnimplementedError;
  }

  @override
  Iterable<E> take(int count) {
    throw UnimplementedError;
  }

  @override
  Iterable<E> takeWhile(bool Function(E value) test) {
    throw UnimplementedError;
  }

  @override
  List<E> toList({bool growable = true}) {
    throw UnimplementedError;
  }

  @override
  Set<E> toSet() {
    throw UnimplementedError;
  }

  @override
  Iterable<E> where(bool Function(E element) test) {
    throw UnimplementedError;
  }

  @override
  Iterable<T> whereType<T>() {
    throw UnimplementedError;
  }
}

/// A list node contains the data value and a link to the next node in the linked list.
class _Node<E> {
  E _data;
  _Node<E> _next;

  E get data => _data;

  set data(E newValue) {
    _data = newValue;
  }

  /// Construct a node with the specified data value and link.
  _Node(E data, _Node<E> next) {
    _data = data;
    _next = next;
  }

  /// Construct a node with the given data value
  _Node.linkLess(E data) {
    _data = data;
  }

  bool equals(_Node<E> node) {
    return _data == node.data;
  }
}

/// An iterator for this singly-linked list.
class _LinkedListIterator<E> implements Iterator<E> {
  var _current;
  _Node<E> _nextElement;

  /// Construct an iterator initialized to the first element in the list.
  _LinkedListIterator(_Node<E> head) {
    _nextElement = head;
  }

  /// Returns true if the iteration has more elements.
  bool hasNext() {
    return _nextElement != null;
  }

  @override
  bool moveNext() {
    if (!hasNext()) {
      return false;
    }
    _current = _nextElement.data;
    _nextElement = _nextElement._next;

    return true;
  }

  @override
  E get current => _current;
}
