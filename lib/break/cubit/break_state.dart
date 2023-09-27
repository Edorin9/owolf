part of 'break_cubit.dart';

@MappableClass()
class BreakState with BreakStateMappable {
  const BreakState({
    this.remainingTime = Duration.zero,
    this.overbreakTime = Duration.zero,
    this.isRunning = false,
    this.isFinished = false,
    this.referenceMode = WorkMode.normal,
  });

  final Duration remainingTime;
  final Duration overbreakTime;
  final bool isRunning;
  final bool isFinished;
  final WorkMode referenceMode;
}
