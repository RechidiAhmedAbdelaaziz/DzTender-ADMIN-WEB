extension ListExtension<T> on List<T> {
  bool equals(List<T> other) {
    if (length != other.length) return false;
    for (var i = 0; i < length; i++) {
      if (contains(other[i])) continue;
      return false;
    }
    return true;
  }

  void addUnique(T item) {
    if (!contains(item)) add(item);
  }

  List<T> withUnique(T item) {
    if (!contains(item)) add(item);
    return this;
  }

  void addAllUnique(List<T> items) => items.forEach(addUnique);

  List<T> withAllUnique(List<T> items) {
    items.forEach(addUnique);
    return this;
  }

  void replace(T item) {
    final index = indexWhere((e) => e == item);
    if (index == -1) return;
    this[index] = item;
  }

  List<T> withReplace(T item) {
    final index = indexWhere((e) => e == item);
    if (index == -1) return this;
    this[index] = item;
    return this;
  }



  List<T> withRemove(T item) {
    final index = indexWhere((e) => e == item);
    if (index == -1) return this;
    removeAt(index);
    return this;
  }

}