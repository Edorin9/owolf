

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
}

extension WorkModeExt on String {
  WorkMode toWorkMode() =>
      WorkMode.values.firstWhere((mode) => mode.name == this);
}
