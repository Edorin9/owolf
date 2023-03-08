import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/ticker.dart';
import '../enums/work_mode.dart';

part 'home_bloc.freezed.dart';
part 'home_bloc.g.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ModeToggled>(_onModeToggled);
    on<StopwatchInitiated>(_onStopwatchInitiated);
    on<StopwatchTicked>(_onStopwatchTicked);
    on<TakeBreakChosen>(_onTakeBreakChosen);
    on<EndSessionChosen>(_onEndSessionChosen);
  }

  StreamSubscription<int>? _tickSubscription;

  @override
  Future<void> close() {
    _tickSubscription?.cancel();
    return super.close();
  }

  Future<void> _onModeToggled(
    ModeToggled event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(mode: state.mode.toggle()));
  }

  Future<void> _onStopwatchInitiated(
    StopwatchInitiated event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isRunning: true));
    // cancel subscription before starting another
    await _tickSubscription?.cancel();
    // listen to count up ticks
    _tickSubscription = countUp().listen((int ticks) {
      final elapsedTime = Duration(seconds: ticks);
      add(StopwatchTicked(elapsedTime));
    });
  }

  Future<void> _onStopwatchTicked(
    StopwatchTicked event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(elapsedTime: event.elapsedTime));
  }

  Future<void> _onTakeBreakChosen(
    TakeBreakChosen event,
    Emitter<HomeState> emit,
  ) async {
    await _resetStopwatch(emit);
  }

  Future<void> _onEndSessionChosen(
    EndSessionChosen event,
    Emitter<HomeState> emit,
  ) async {
    await _resetStopwatch(emit);
  }

  Future<void> _resetStopwatch(Emitter<HomeState> emit) async {
    // unsubscribe to ticks - reset state
    await _tickSubscription?.cancel();
    emit(const HomeState());
  }
}
