import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:utility/utility.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/work_mode.dart';

part 'home_cubit.mapper.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const HomeState());

  final SettingsRepository _settingsRepository;
  StreamSubscription<int>? _tickSubscription;
  StreamSubscription<String>? _modeSubscription;

  double _minutesInPeriod = 25;
  double breakLengthPerPeriod = 5;

  @override
  Future<void> close() async {
    await _tickSubscription?.cancel();
    await _modeSubscription?.cancel();
    return super.close();
  }

  void initState() {
    final mode =
        _settingsRepository.getTimerMode()?.toWorkMode() ?? WorkMode.periodic;
    _minutesInPeriod = _settingsRepository.getPeriodLength() ?? 25;
    breakLengthPerPeriod = _settingsRepository.getPeriodicBreakLength() ?? 5;
    debugPrint(
        'initState() => mode: $mode, minutesInPeriod: $_minutesInPeriod');
    emit(
      state.copyWith(
        status: HomeStateStatus.idle,
        mode: mode,
        time: mode.getStartTime(minutesInPeriod: _minutesInPeriod),
        period: 0,
      ),
    );
    _subscribeToModeChange();
  }

  void toggleMode() {
    final newMode = state.mode.opposite;
    _settingsRepository.setTimerMode(newMode.name);
  }

  Future<void> startTimer() async {
    await _tickSubscription?.cancel();
    emit(state.copyWith(status: HomeStateStatus.running));
    _startTicks();
  }

  Future<void> resetTimer() async {
    await _tickSubscription?.cancel();
    emit(
      state.copyWith(
        status: HomeStateStatus.idle,
        time: state.mode.getStartTime(minutesInPeriod: _minutesInPeriod),
        period: 0,
      ),
    );
  }

  /// Stop the tick subscription without clearing the state.
  ///
  /// Utilize this in place of [resetTimer] if you want to stop the ticker
  /// from triggering further state updates.
  ///
  Future<void> stopTicks() async => await _tickSubscription?.cancel();

  void _subscribeToModeChange() {
    _modeSubscription = _settingsRepository.timerMode.listen(
      (timerMode) {
        debugPrint('_subscribeToModeChange => $timerMode');
        final newMode = timerMode.toWorkMode();
        emit(
          state.copyWith(
            mode: newMode,
            time: newMode.getStartTime(minutesInPeriod: _minutesInPeriod),
            period: 0,
          ),
        );
      },
    );
  }

  void _startTicks() {
    _tickSubscription = switch (state.mode) {
      WorkMode.fluid => countUp().listen(_handleCountUpTick),
      WorkMode.periodic =>
        countdown(_minutesInPeriod.minutes).listen(_handleCountdownTick)
    };
  }

  void _handleCountUpTick(int tickCount) =>
      emit(state.copyWith(time: tickCount.seconds));

  void _handleCountdownTick(int tickCount) async {
    if (tickCount == 0) {
      await _tickSubscription?.cancel();
      emit(
        state.copyWith(
          status: HomeStateStatus.idle,
          time: tickCount.seconds,
          period: state.period + 1,
        ),
      );
      // status is set to .running right after it was set to .idle
      // to start counting down again immediately
      // (behavior for periodic mode)
      // we will not interrupt the user's timer for the next period
      // if they intend to continue working
      emit(state.copyWith(status: HomeStateStatus.running));
      _startTicks();
    } else {
      emit(state.copyWith(time: tickCount.seconds));
    }
  }
}
