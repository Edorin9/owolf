part of 'settings_cubit.dart';

@MappableClass()
class SettingsState with SettingsStateMappable {
  const SettingsState({
    this.timerMode = WorkMode.fluid,
    this.fluidBreakLengthType = PreferenceValueType.defaultValue,
    this.fluidBreakLength = 0.2,
    this.periodLength = 25,
    this.periodicBreakLength = 5,
  });

  /// Active timer mode
  ///
  final WorkMode timerMode;

  /// Selected [fluid] break time value type (default or custom)
  ///
  final PreferenceValueType fluidBreakLengthType;

  /// Selected [fluid] break length (in minutes) preference
  ///
  /// Custom value of [fluidBreakLengthType]
  /// <br/>Fraction of total time worked
  ///
  final double fluidBreakLength;

  /// Selected period length (in minutes)
  ///
  final double periodLength;

  /// Selected period break length (in minutes)
  ///
  /// [periodicBreakLength] for every conmpleted period'
  ///
  final double periodicBreakLength;
}
