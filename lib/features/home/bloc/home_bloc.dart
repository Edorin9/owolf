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

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeState());

  StreamSubscription<int>? _tickSubscription;

  @override
  Future<void> close() {
    _tickSubscription?.cancel();
    return super.close();
  }

  void toggleMode() {
    emit(state.copyWith(mode: state.mode.toggle()));
  }

  Future<void> initiateStopWatch() async {
    emit(state.copyWith(isRunning: true));
    // cancel subscription before starting another
    await _tickSubscription?.cancel();
    // listen to count up ticks
    _tickSubscription = countUp().listen((int ticks) {
      final elapsedTime = Duration(seconds: ticks);
      emit(state.copyWith(elapsedTime: elapsedTime));
    });
  }

  Future<void> resetStopwatch() async {
    // unsubscribe to ticks - reset state
    await _tickSubscription?.cancel();
    emit(const HomeState());
  }
}
