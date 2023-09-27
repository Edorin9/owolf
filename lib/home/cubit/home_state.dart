part of 'home_cubit.dart';

enum HomeStateStatus { idle, running }

@MappableClass()
class HomeState with HomeStateMappable {
  const HomeState({
    this.mode = WorkMode.normal,
    this.status = HomeStateStatus.idle,
    this.elapsedTime = Duration.zero,
    this.remainingTime = Duration.zero,
  });

  final WorkMode mode;
  final HomeStateStatus status;
  final Duration elapsedTime;
  final Duration remainingTime;

  // TODO: implement configurability on preferences
  Duration get breakDuration => elapsedTime > 90.minutes
      ? 15.minutes
      : elapsedTime > 50.minutes && elapsedTime <= 90.minutes
          ? 10.minutes
          : elapsedTime > 25.minutes && elapsedTime <= 50.minutes
              ? 8.minutes
              : 5.minutes;
}
