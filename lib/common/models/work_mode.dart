import 'package:utility/extensions.dart';

/// Work modes to handle timer types - either stopwatch or countdown timer.
///
/// Break duration is computed based on how long you worked.
enum WorkMode {
  /// Flowtime Stopwatch - take a break anytime.
  fluid,

  /// Pomodoro Countdown Timer - work and take breaks on set durations.
  periodic;

  /// Switch between [WorkMode.fluid] and [WorkMode.periodic].
  WorkMode toggle() =>
      this == WorkMode.fluid ? WorkMode.periodic : WorkMode.fluid;

  Duration getStartTime({num minutesInPeriod = 25}) {
    switch (this) {
      case WorkMode.fluid:
        return Duration.zero;
      case WorkMode.periodic:
        return minutesInPeriod.minutes;
    }
  }
}
