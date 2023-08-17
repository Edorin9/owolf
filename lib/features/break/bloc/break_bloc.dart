import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/ticker.dart';
import '../../home/enums/work_mode.dart';

part 'break_bloc.freezed.dart';
part 'break_bloc.g.dart';
part 'break_event.dart';
part 'break_state.dart';

class BreakBloc extends Cubit<BreakState> {
  BreakBloc(
    Duration duration,
    WorkMode referenceMode,
  ) : super(BreakState(remainingTime: duration, referenceMode: referenceMode)) {
    print(duration);
  }

  StreamSubscription<int>? _tickSubscription;

  @override
  Future<void> close() {
    _tickSubscription?.cancel();
    return super.close();
  }

  void initiateCountdown() {
    emit(state.copyWith(isRunning: true));
    // cancel subscription before starting another
    _tickSubscription?.cancel();
    // listen to countdown ticks
    _tickSubscription = countdown(state.remainingTime).listen((int ticks) {
      // register countdown ticks - if zero is reached, stop timer
      final remainingTime = Duration(seconds: ticks);
      emit(state.copyWith(remainingTime: remainingTime));
      if (remainingTime.inSeconds == 0) _endCountdown();
    });
  }

  void _endCountdown() {
    _tickSubscription?.cancel();

    emit(state.copyWith(isRunning: false, isFinished: true));

    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true,
      asAlarm: false,
    );
  }
}
