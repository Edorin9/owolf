part of 'break_bloc.dart';

@freezed
class BreakState with _$BreakState {
  const factory BreakState({
    @Default(Duration.zero) Duration remainingTime,
    @Default(Duration.zero) Duration overbreakTime,
    @Default(false) bool isRunning,
    @Default(false) bool isFinished,
    @Default(WorkMode.normal) WorkMode referenceMode,
  }) = _BreakState;

  factory BreakState.fromJson(Map<String, dynamic> json) =>
      _$BreakStateFromJson(json);
}
