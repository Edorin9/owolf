import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_repository/settings_repository.dart';

import '../../common/models/models.dart';

part 'settings_cubit.mapper.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const SettingsState());

  final SettingsRepository _settingsRepository;

  StreamSubscription<String>? _timerModeSubscription;
  StreamSubscription<({String type, double? value})>?
      _fluidBreakLengthSubscription;
  StreamSubscription<bool>? _periodAlertSubscription;
  StreamSubscription<double>? _periodLengthSubscription;
  StreamSubscription<double>? _periodicBreakLengthSubscription;

  void initState() async {
    final fullSettings = _settingsRepository.getFullSettings();
    final workMode = fullSettings.timerMode?.toWorkMode();
    final fluidBreakLength = fullSettings.fluidBreakLength;
    final isPeriodAlertEnabled = fullSettings.periodAlert;
    final periodLength = fullSettings.periodLength;
    final periodicBreakLength = fullSettings.periodicBreakLength;
    // set initial settings
    emit(
      state.copyWith(
        timerMode: workMode,
        fluidBreakLengthType: fluidBreakLength.type?.toPreferenceValueType(),
        fluidBreakLength: fluidBreakLength.value,
        isPeriodAlertEnabled: isPeriodAlertEnabled,
        periodLength: periodLength,
        periodicBreakLength: periodicBreakLength,
      ),
    );
    _subscribeToSettingChanges();
  }

  @override
  Future<void> close() {
    _timerModeSubscription?.cancel();
    _fluidBreakLengthSubscription?.cancel();
    _periodAlertSubscription?.cancel();
    _periodLengthSubscription?.cancel();
    _periodicBreakLengthSubscription?.cancel();
    return super.close();
  }

  void toggleMode(WorkMode mode) => _settingsRepository.setTimerMode(mode.name);

  void saveFluidBreakLength({
    PreferenceValueType? type,
    double? value,
  }) {
    _settingsRepository.setFluidBreakLength(
      type: type?.name ?? state.fluidBreakLengthType.name,
      value: value,
    );
  }

  void savePeriodAlert(bool isEnabled) =>
      _settingsRepository.setPeriodAlert(isEnabled);

  void savePeriodLength(double period) =>
      _settingsRepository.setPeriodLength(period);

  void savePeriodBreakLength(double breakLength) =>
      _settingsRepository.setPeriodicBreakLength(breakLength);

  void _subscribeToSettingChanges() {
    _timerModeSubscription = _settingsRepository.timerMode.listen(
      (timerMode) {
        emit(state.copyWith(timerMode: timerMode.toWorkMode()));
      },
    );
    _fluidBreakLengthSubscription = _settingsRepository.fluidBreakLength.listen(
      (fluidBreakLength) {
        emit(
          state.copyWith(
            fluidBreakLengthType: fluidBreakLength.type.toPreferenceValueType(),
            fluidBreakLength: fluidBreakLength.value,
          ),
        );
      },
    );
    _periodAlertSubscription = _settingsRepository.periodAlert.listen(
      (periodAlert) {
        emit(state.copyWith(isPeriodAlertEnabled: periodAlert));
      },
    );
    _periodLengthSubscription = _settingsRepository.periodLength.listen(
      (periodLength) {
        emit(state.copyWith(periodLength: periodLength));
      },
    );
    _periodicBreakLengthSubscription =
        _settingsRepository.periodicBreakLength.listen(
      (periodicBreakLength) {
        emit(state.copyWith(periodicBreakLength: periodicBreakLength));
      },
    );
  }
}
