part of 'break_bloc.dart';

@freezed
class BreakEvent with _$BreakEvent {
  const factory BreakEvent.countdownInititated() = CountdownInititated;
  const factory BreakEvent.countdownTicked([
    @Default(Duration.zero) Duration remainingTime,
  ]) = CountdownTicked;
  const factory BreakEvent.countdownEnded() = CountdownEnded;

  factory BreakEvent.fromJson(Map<String, dynamic> json) =>
      _$BreakEventFromJson(json);
}
