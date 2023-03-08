part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(WorkMode.normal) WorkMode mode,
    @Default(false) bool isRunning,
    @Default(Duration.zero) Duration elapsedTime,
    @Default(Duration.zero) Duration remainingTime,
  }) = _HomeState;

  const HomeState._();

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);

  Duration get breakDuration => elapsedTime * 0.3;
}
