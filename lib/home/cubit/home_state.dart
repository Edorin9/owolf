part of 'home_cubit.dart';

enum HomeStateStatus { idle, running }

@MappableClass()
class HomeState with HomeStateMappable {
  const HomeState({
    this.status = HomeStateStatus.idle,
    this.mode = WorkMode.periodic,
    this.time = Duration.zero,
    this.period = 0,
    this.minutesInPeriod = 25,
    this.breakLengthPerPeriod = 5,
    this.fluidBreakLength = (
      type: PreferenceValueType.defaultValue,
      value: 0.2,
    ),
  });

  /// Status of [HomeState]
  ///
  final HomeStateStatus status;

  /// Active timer mode
  ///
  final WorkMode mode;

  /// Current time [Duration] set on the timer
  ///
  final Duration time;

  /// Number of intervals ran in [WorkMode.periodic] timer
  ///
  /// Used as multiplicand for computing length of break time
  ///
  final int period;

  /// Length of a unit [period] in [WorkMode.periodic]
  ///
  final double minutesInPeriod;

  /// Length of break time per period
  ///
  /// Used as multiplier for computing length of break time in [WorkMode.periodic]
  ///
  final double breakLengthPerPeriod;

  /// Fluid mode break length [type] and [value] record
  ///
  /// Used to compute for [WorkMode.fluid] break duration
  ///
  final ({PreferenceValueType? type, double? value}) fluidBreakLength;

  /// Get starting time for timers
  ///
  /// [WorkMode.fluid] -> 0:00 (counting up)
  /// <br/>[WorkMode.periodic] -> [minutesInPeriod]:00 (counting down)
  ///
  Duration calculateStartTime({
    WorkMode? forMode,
    double? withMinutesInPeriod,
  }) =>
      switch (forMode ?? mode) {
        WorkMode.fluid => Duration.zero,
        WorkMode.periodic => (withMinutesInPeriod ?? minutesInPeriod).minutes,
      };

  /// Compute for the length of break time depending on the [WorkMode] active.
  ///
  /// [breakLengthPerPeriod] is the multiplier for [period]
  ///
  Duration get breakDuration => switch (mode) {
        WorkMode.fluid => switch (
              fluidBreakLength.type ?? PreferenceValueType.defaultValue) {
            PreferenceValueType.defaultValue => time > 90.minutes
                ? 15.minutes
                : time > 50.minutes && time <= 90.minutes
                    ? 10.minutes
                    : time > 25.minutes && time <= 50.minutes
                        ? 8.minutes
                        : 5.minutes,
            PreferenceValueType.customValue =>
              time * (fluidBreakLength.value ?? 0.2)
          },
        WorkMode.periodic => (period * breakLengthPerPeriod).minutes
      };
}
