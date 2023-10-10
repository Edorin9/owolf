part of 'home_cubit.dart';

enum HomeStateStatus { idle, running }

@MappableClass()
class HomeState with HomeStateMappable {
  const HomeState({
    this.status = HomeStateStatus.idle,
    this.mode = WorkMode.periodic,
    this.time = Duration.zero,
    this.period = 0,
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

  /// Compute for the length of break time depending on the [WorkMode] active.
  ///
  /// [breakLengthPerPeriod] is the multiplier for [period]
  ///
  Duration getBreakDuration({double breakLengthPerPeriod = 5}) =>
      switch (mode) {
        WorkMode.fluid => time > 90.minutes
            ? 15.minutes
            : time > 50.minutes && time <= 90.minutes
                ? 10.minutes
                : time > 25.minutes && time <= 50.minutes
                    ? 8.minutes
                    : 5.minutes,
        WorkMode.periodic => (period * breakLengthPerPeriod).minutes
      };
}
