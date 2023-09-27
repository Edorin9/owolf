part of 'home_cubit.dart';

@MappableClass()
class HomeState with HomeStateMappable {
  const HomeState({
    this.mode = WorkMode.normal,
    this.isRunning = false,
    this.elapsedTime = Duration.zero,
    this.remainingTime = Duration.zero,
  });

  final WorkMode mode;
  final bool isRunning;
  final Duration elapsedTime;
  final Duration remainingTime;

  Duration get breakDuration => elapsedTime * 0.3;
}
