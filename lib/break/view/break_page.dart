import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../home/models/work_mode.dart';
import '../cubit/break_cubit.dart';
import '../widgets/widgets.dart';

class BreakPage extends StatelessWidget {
  const BreakPage._();

  static Route<void> route({
    required Duration duration,
    required WorkMode referenceMode,
  }) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) =>
              BreakCubit(duration, referenceMode)..initiateCountdown(),
          child: const BreakPage._(),
        ),
      );

  @override
  Widget build(BuildContext context) => const _BreakView();
}

class _BreakView extends StatelessWidget {
  const _BreakView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreakCubit, BreakState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == BreakStateStatus.completed,
      listener: (context, state) async {
        await FlutterRingtonePlayer.play(
          android: AndroidSounds.notification,
          ios: IosSounds.glass,
          looping: true,
          asAlarm: false,
        );
      },
      child: const Scaffold(
        body: Center(
          child: Stack(
            children: [
              StatusBackground(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 27),
                  DisplayImage(),
                  TimerFace(),
                  ResumeButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 27),
        DisplayImage(),
        TimerFace(),
        ResumeButton(),
      ],
    );
  }
}
