part of 'break_cubit.dart';

enum BreakStateStatus { idle, running, completed }

@MappableClass()
class BreakState with BreakStateMappable {
  const BreakState({
    this.status = BreakStateStatus.idle,
    this.remainingTime = Duration.zero,
    this.overbreakTime = Duration.zero,
    this.referenceMode = WorkMode.fluid,
  });

  final BreakStateStatus status;
  final Duration remainingTime;
  final Duration overbreakTime;
  final WorkMode referenceMode;
}
