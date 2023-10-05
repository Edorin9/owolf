import 'dart:async';

import 'package:utility/utility.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/work_mode.dart';

part 'home_cubit.mapper.dart';
part 'home_state.dart';

const minutesInPeriod = 0.1;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  StreamSubscription<int>? _tickSubscription;

  @override
  Future<void> close() async {
    await _tickSubscription?.cancel();
    return super.close();
  }

  void initState() {
    const mode = WorkMode.periodic;
    emit(
      state.copyWith(
        status: HomeStateStatus.idle,
        mode: mode,
        time: mode.getStartTime(minutesInPeriod: minutesInPeriod),
        period: 0,
      ),
    );
  }

  void toggleMode() {
    final newMode = state.mode.toggle();
    emit(
      state.copyWith(
        mode: newMode,
        time: newMode.getStartTime(minutesInPeriod: minutesInPeriod),
        period: 0,
      ),
    );
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
        time: state.mode.getStartTime(minutesInPeriod: minutesInPeriod),
        period: 0,
      ),
    );
  }

  /// Used to stop the tick subscription without clearing the state.
  ///
  /// Utilize this in place of [resetTimer] if you want to stop the ticker
  /// from triggering further state updates.
  Future<void> stopTicks() async => await _tickSubscription?.cancel();

  void _startTicks() {
    _tickSubscription = switch (state.mode) {
      WorkMode.fluid => countUp().listen(_handleFluidTick),
      WorkMode.periodic =>
        countdown(minutesInPeriod.minutes).listen(_handleCountdownTick)
    };
  }

  void _handleFluidTick(int tickCount) =>
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
