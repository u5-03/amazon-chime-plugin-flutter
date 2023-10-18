extension ListExt<T> on List<T?> {
  List<T> get nonNullable {
    return where((item) => item != null).map((item) => item!).toList();
  }
}
