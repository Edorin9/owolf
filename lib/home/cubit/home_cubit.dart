import 'dart:async';

import 'package:common/helpers.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:common/extensions.dart';

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
    await _tickSubscription?.cancel();
    emit(state.copyWith(status: HomeStateStatus.running));
    _tickSubscription = countUp().listen(_handleTick);
  }

  Future<void> resetStopwatch() async {
    await _tickSubscription?.cancel();
    emit(const HomeState());
  }

  void _handleTick(int tickCount) {
    final elapsedTime = Duration(seconds: tickCount);
    emit(state.copyWith(elapsedTime: elapsedTime));
  }
}
