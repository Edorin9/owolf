import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/ticker.dart';
import '../../home/enums/work_mode.dart';

part 'break_bloc.freezed.dart';
part 'break_bloc.g.dart';
part 'break_event.dart';
part 'break_state.dart';

class BreakBloc extends Bloc<BreakEvent, BreakState> {
  BreakBloc(
    Duration duration,
    WorkMode referenceMode,
  ) : super(BreakState(remainingTime: duration, referenceMode: referenceMode)) {
    on<CountdownInititated>(_onCountdownInitiated);
    on<CountdownTicked>(_onCountdownTicked);
    on<CountdownEnded>(_onCountdownEnded);
  }

  StreamSubscription<int>? _tickSubscription;

  @override
  Future<void> close() {
    _tickSubscription?.cancel();
    return super.close();
  }

  Future<void> _onCountdownInitiated(
    CountdownInititated event,
    Emitter<BreakState> emit,
  ) async {
    emit(state.copyWith(isRunning: true));
    // cancel subscription before starting another
    await _tickSubscription?.cancel();
    // listen to countdown ticks
    _tickSubscription = countdown(state.remainingTime).listen((int ticks) {
      // register countdown ticks - if zero is reached, stop timer
      final remainingTime = Duration(seconds: ticks);
      add(CountdownTicked(remainingTime));
      if (remainingTime.inSeconds == 0) add(const CountdownEnded());
    });
  }

  Future<void> _onCountdownTicked(
    CountdownTicked event,
    Emitter<BreakState> emit,
  ) async {
    emit(state.copyWith(remainingTime: event.remainingTime));
  }

  Future<void> _onCountdownEnded(
    CountdownEnded event,
    Emitter<BreakState> emit,
  ) async {
    await _tickSubscription?.cancel();
    emit(state.copyWith(isRunning: false));
  }
}
