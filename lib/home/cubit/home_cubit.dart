import 'dart:async';
import 'dart:developer';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:utility/utility.dart';

import '../../common/models/models.dart';

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

  @override
  Future<void> close() async {
    await _tickSubscription?.cancel();
    await _modeSubscription?.cancel();
    return super.close();
  }

  void initState() {
    final mode = WorkMode.from(
      _settingsRepository.getTimerMode() ?? WorkMode.periodic.name,
    );
    final minutesInPeriod = _settingsRepository.getPeriodLength();
    final startTime = state.calculateStartTime(
      forMode: mode,
      withMinutesInPeriod: minutesInPeriod,
    );
    final breakLengthPerPeriod = _settingsRepository.getPeriodicBreakLength();
    final fluidBreakLength = _settingsRepository.getFluidBreakLength();
    final typedFluidBreakLength = (
      type: PreferenceValueType.from(
        fluidBreakLength.type ?? PreferenceValueType.defaultValue.name,
      ),
      value: fluidBreakLength.value ?? 0.2,
    );
    log('''initState() =>
    mode: $mode
    minutesInPeriod: $minutesInPeriod
    startTime: $startTime
    breakLengthPerPeriod: $breakLengthPerPeriod
    fluidBreakLength: $fluidBreakLength
    typedFluidBreakLength: $typedFluidBreakLength
    ''');
    emit(
      state.copyWith(
        status: HomeStateStatus.idle,
        mode: mode,
        time: startTime,
        period: 0,
        minutesInPeriod: minutesInPeriod,
        breakLengthPerPeriod: breakLengthPerPeriod,
        fluidBreakLength: typedFluidBreakLength,
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
        time: state.calculateStartTime(),
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

  bool getPeriodAlert() => _settingsRepository.getPeriodAlert() ?? true;

  void _subscribeToModeChange() {
    _modeSubscription?.cancel();
    _modeSubscription = _settingsRepository.timerMode.listen(
      (timerMode) {
        log('_subscribeToModeChange => $timerMode');
        final newMode = WorkMode.from(timerMode);
        emit(
          state.copyWith(
            mode: newMode,
            time: state.calculateStartTime(forMode: newMode),
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
        countdown(state.minutesInPeriod.minutes).listen(_handleCountdownTick)
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
