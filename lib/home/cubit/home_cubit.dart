import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/ticker.dart';
import '../models/work_mode.dart';

part 'home_cubit.mapper.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

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
