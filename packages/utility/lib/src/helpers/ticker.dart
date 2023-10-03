import 'package:utility/extensions.dart';

/// Emits an [int] with the value of previously emitted [int] plus 1,
/// every second.
///
Stream<int> countUp() {
  return Stream.periodic(
    1000.milliseconds,
    (int ticks) => ticks + 1,
  );
}

/// Emits an [int] with the value of previously emitted [int] minus 1,
/// every second.
///
Stream<int> countdown(Duration duration) {
  return Stream.periodic(
    1000.milliseconds,
    (int ticks) => duration.inSeconds - (ticks + 1),
  );
}
