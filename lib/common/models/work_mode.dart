import 'package:utility/extensions.dart';

/// Work modes to handle timer types - either [fluid] or [periodic] timer.
///
/// Break duration is computed based on how long you worked.
///
enum WorkMode {
  /// Flowtime Stopwatch - take a break anytime.
  ///
  fluid,

  /// Pomodoro Countdown Timer - work and take breaks on set durations.
  ///
  periodic;

  /// Return the other mode
  ///
  /// fluid to periodic and vice-versa
  ///
  WorkMode get opposite =>
      this == WorkMode.fluid ? WorkMode.periodic : WorkMode.fluid;

  /// Get starting time for timers
  ///
  /// [fluid] -> 0:00 (counting up)
  /// <br/>[periodic] -> [minutesInPeriod]:00 (counting down)
  ///
  Duration getStartTime({num minutesInPeriod = 25}) {
    switch (this) {
      case WorkMode.fluid:
        return Duration.zero;
      case WorkMode.periodic:
        return minutesInPeriod.minutes;
    }
  }
}
