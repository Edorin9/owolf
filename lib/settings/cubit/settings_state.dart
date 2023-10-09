part of 'settings_cubit.dart';

@MappableClass()
class SettingsState with SettingsStateMappable {
  const SettingsState({
    this.timer = WorkMode.periodic,
  });

  /// Active timer mode
  ///
  final WorkMode timer;
}
