import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../../util/ticker.dart';
import '../../home/models/work_mode.dart';

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
    emit(state.copyWith(isRunning: true));
    // cancel subscription before starting another
    await _tickSubscription?.cancel();
    // listen to countdown ticks
    _tickSubscription = countdown(state.remainingTime).listen((int ticks) {
      // register countdown ticks - if zero is reached, stop timer
      final remainingTime = Duration(seconds: ticks);
      emit(state.copyWith(remainingTime: remainingTime));
      if (remainingTime.inSeconds == 0) _endCountdown();
    });
  }

  Future<void> stopCountdown() async {
    await _tickSubscription?.cancel();
    emit(state.copyWith(isRunning: false, isFinished: true));
  }

  Future<void> _endCountdown() async {
    await stopCountdown();

    await FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true,
      asAlarm: false,
    );
  }
}
