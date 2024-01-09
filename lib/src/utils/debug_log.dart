void debugLog(String message) {
  // ignore: prefer_asserts_with_message
  assert(() {
    // ignore: avoid_print
    print(message);
    return true;
  }());
}
