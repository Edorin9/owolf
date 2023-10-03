import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/extensions.dart';
import 'package:utility/helpers.dart';

import '../../common/models/work_mode.dart';

part 'break_cubit.mapper.dart';
part 'break_state.dart';

class BreakCubit extends Cubit<BreakState> {
  BreakCubit(
    Duration duration,
    WorkMode referenceMode,
  ) : super(BreakState(remainingTime: duration, referenceMode: referenceMode));

  StreamSubscription<int>? _tickSubscription;

  @override
  Future<void> close() {
    _tickSubscription?.cancel();
    return super.close();
  }

  Future<void> initiateCountdown() async {
    await _tickSubscription?.cancel();
    emit(state.copyWith(status: BreakStateStatus.running));
    _tickSubscription = countdown(state.remainingTime).listen(_handleTick);
  }

  void _handleTick(int tickCount) {
    final remainingTime = tickCount.seconds;
    emit(state.copyWith(remainingTime: remainingTime));
    if (remainingTime.inSeconds == 0) _endCountdown();
  }

  Future<void> _endCountdown() async {
    await _tickSubscription?.cancel();
    emit(state.copyWith(status: BreakStateStatus.completed));
  }
}
