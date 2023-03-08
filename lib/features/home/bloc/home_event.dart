part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.modeToggled() = ModeToggled;

  const factory HomeEvent.stopwatchInitiated() = StopwatchInitiated;

  const factory HomeEvent.stopwatchTicked([
    @Default(Duration.zero) Duration elapsedTime,
  ]) = StopwatchTicked;

  const factory HomeEvent.takeBreakChosen() = TakeBreakChosen;
  const factory HomeEvent.endSessionChosen() = EndSessionChosen;

  factory HomeEvent.fromJson(Map<String, dynamic> json) =>
      _$HomeEventFromJson(json);
}
