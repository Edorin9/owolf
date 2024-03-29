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

  /// Status of [BreakState]
  ///
  final BreakStateStatus status;

  /// Time remaining until break time is over
  ///
  final Duration remainingTime;

  /// Additional break time spent after set time
  ///
  /// Accumulation starts when break time has ended,
  /// and ends when work is resumed.
  ///
  final Duration overbreakTime;

  /// Timer mode that started the break time
  ///
  final WorkMode referenceMode;
}
