/// Emits an [int] with the value of previously emitted [int] plus 1,
/// every second.
///
Stream<int> countUp() {
  return Stream.periodic(
    const Duration(milliseconds: 1000),
    (int ticks) => ticks + 1,
  );
}

/// Emits an [int] with the value of previously emitted [int] minus 1,
/// every second.
///
Stream<int> countdown(Duration duration) {
  return Stream.periodic(
    const Duration(milliseconds: 1000),
    (int ticks) => duration.inSeconds - (ticks + 1),
  );
}
