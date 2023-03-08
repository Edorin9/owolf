/// Work modes to handle timer types - either stopwatch or countdown timer.
///
/// Break duration is computed based on how long you worked.
///
enum WorkMode {
  /// Stopwatch - take a break anytime.
  ///
  normal,

  /// Countdown Timer - work and take a break on set durations.
  ///
  slave,
}

extension WorkModeExt on WorkMode {
  /// Toggle between [WorkMode.normal] and [WorkMode.slave].
  WorkMode toggle() =>
      (this == WorkMode.normal) ? WorkMode.slave : WorkMode.normal;
}
