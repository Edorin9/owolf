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

  Duration get breakDuration => elapsedTime * 0.3;
}
