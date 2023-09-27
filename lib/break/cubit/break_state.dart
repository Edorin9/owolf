part of 'break_cubit.dart';

enum BreakStateStatus { idle, running, completed }

@MappableClass()
class BreakState with BreakStateMappable {
  const BreakState({
    this.remainingTime = Duration.zero,
    this.overbreakTime = Duration.zero,
    this.status = BreakStateStatus.idle,
    this.referenceMode = WorkMode.normal,
  });

  final Duration remainingTime;
  final Duration overbreakTime;
  final BreakStateStatus status;
  final WorkMode referenceMode;
}
