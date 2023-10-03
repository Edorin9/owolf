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

  final HomeStateStatus status;
  final WorkMode mode;
  final Duration time;
  final int period;

  Duration getBreakDuration({double breakMinutesPerPeriod = 5}) =>
      switch (mode) {
        WorkMode.fluid => time > 90.minutes
            ? 15.minutes
            : time > 50.minutes && time <= 90.minutes
                ? 10.minutes
                : time > 25.minutes && time <= 50.minutes
                    ? 8.minutes
                    : 5.minutes,
        WorkMode.periodic => (period * breakMinutesPerPeriod).minutes
      };
}
