part of 'break_bloc.dart';

@freezed
class BreakEvent with _$BreakEvent {
  const factory BreakEvent.countdownInititated() = CountdownInititated;
  const factory BreakEvent.countdownTicked([
    @Default(Duration.zero) Duration remainingTime,
  ]) = CountdownTicked;
  const factory BreakEvent.countdownEnded() = CountdownEnded;
  const factory BreakEvent.overbreakCounterInitiated() =
      OverbreakCounterInitiated;
  const factory BreakEvent.overbreakCounterTicked([
    @Default(Duration.zero) Duration remainingTime,
  ]) = OverbreakCounterTicked;
  const factory BreakEvent.overbreakCounterEnded() = OverbreakCounterEnded;

  factory BreakEvent.fromJson(Map<String, dynamic> json) =>
      _$BreakEventFromJson(json);
}
