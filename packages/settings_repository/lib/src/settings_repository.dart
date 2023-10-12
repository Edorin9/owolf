import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'keys.dart';

class SettingsRepository {
  SettingsRepository(SharedPreferences sharedPreferences)
      : _prefs = sharedPreferences;

  final SharedPreferences _prefs;

  final _timerModeController = BehaviorSubject<String>();
  final _fluidBreakLengthController =
      BehaviorSubject<({String type, double? value})>();
  final _periodAlertController = BehaviorSubject<bool>();
  final _periodLengthController = BehaviorSubject<double>();
  final _periodicBreakLengthController = BehaviorSubject<double>();

  /// Active timer mode
  ///
  /// Streams a [String] of WorkMode type
  ///
  Stream<String> get timerMode => _timerModeController.asBroadcastStream();

  /// Break length for fluid timer mode
  ///
  /// Streams a record of [String] type of either default or custom,
  /// and optional [double] value (in minutes) if type is custom
  ///
  Stream<({String type, double? value})> get fluidBreakLength =>
      _fluidBreakLengthController.asBroadcastStream();

  /// Period complete alert tone
  ///
  /// Streams a [bool]
  ///
  Stream<bool> get periodAlert => _periodAlertController.asBroadcastStream();

  /// Length of one periodic timer interval (period)
  ///
  /// Streams a [double] value (in minutes)
  ///
  Stream<double> get periodLength =>
      _periodLengthController.asBroadcastStream();

  /// Break length for periodic timer mode
  ///
  /// Streams a [double] value (in minutes)
  ///
  Stream<double> get periodicBreakLength =>
      _periodicBreakLengthController.asBroadcastStream();

  /// Get the full record of settings from shared preferences
  ///
  ({
    String? timerMode,
    ({String? type, double? value}) fluidBreakLength,
    bool? periodAlert,
    double? periodLength,
    double? periodicBreakLength,
  }) getFullSettings() => (
        timerMode: getTimerMode(),
        fluidBreakLength: getFluidBreakLength(),
        periodAlert: getPeriodAlert(),
        periodLength: getPeriodLength(),
        periodicBreakLength: getPeriodicBreakLength(),
      );

  /// Get timer mode from shared preferences
  ///
  String? getTimerMode() => _prefs.getString(Keys.timerMode);

  /// Sets timer mode in shared preferences
  ///
  Future<void> setTimerMode(String timerMode) async {
    final isSaved = await _prefs.setString(Keys.timerMode, timerMode);
    if (isSaved) _timerModeController.add(timerMode);
  }

  /// Get fluid break length [type] and [value] from shared preferences
  ///
  ({String? type, double? value}) getFluidBreakLength() {
    return (
      type: _prefs.getString(Keys.fluidBreakLengthType),
      value: _prefs.getDouble(Keys.fluidBreakLengthValue)
    );
  }

  /// Sets fluid break length type and value in shared preferences
  ///
  /// Accepts a [String] [type] of either default or custom,
  /// and an optional [double] value (in minutes)
  ///
  Future<void> setFluidBreakLength({
    required String type,
    double? value,
  }) async {
    final isTypeSaved = await _prefs.setString(Keys.fluidBreakLengthType, type);
    final isValueSaved = value != null
        ? await _prefs.setDouble(Keys.fluidBreakLengthValue, value)
        : await _prefs.remove(Keys.fluidBreakLengthValue);

    if (isTypeSaved && isValueSaved) {
      _fluidBreakLengthController.add((type: type, value: value));
    }
  }

  /// Get period alert from shared preferences
  ///
  bool? getPeriodAlert() => _prefs.getBool(Keys.periodAlert);

  /// Sets period alert in shared preferences
  ///
  /// Accepts a [bool] [isEnabled]
  ///
  Future<void> setPeriodAlert(bool isEnabled) async {
    final isSaved = await _prefs.setBool(Keys.periodAlert, isEnabled);
    if (isSaved) _periodAlertController.add(isEnabled);
  }

  /// Get period length from shared preferences
  ///
  double? getPeriodLength() => _prefs.getDouble(Keys.periodLength);

  /// Sets period length in shared preferences
  ///
  /// Accepts a [double] [value] (in minutes)
  ///
  Future<void> setPeriodLength(double value) async {
    final isSaved = await _prefs.setDouble(Keys.periodLength, value);
    if (isSaved) _periodLengthController.add(value);
  }

  /// Get periodic break length from shared preferences
  ///
  double? getPeriodicBreakLength() =>
      _prefs.getDouble(Keys.periodicBreakLength);

  /// Sets periodic break length in shared preferences
  ///
  /// Accepts a [double] [value] (in minutes)
  ///
  Future<void> setPeriodicBreakLength(double value) async {
    final isSaved = await _prefs.setDouble(Keys.periodicBreakLength, value);
    if (isSaved) _periodicBreakLengthController.add(value);
  }
}
