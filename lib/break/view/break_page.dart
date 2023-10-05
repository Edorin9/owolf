import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/constants.dart';

import '../../common/models/work_mode.dart';
import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class BreakPage extends StatelessWidget {
  const BreakPage({super.key, required this.args});

  final BreakPageArgs args;

  static const routeName = 'break';
  static const routePath = '/break';

  static GoRoute route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => BreakPage(
      args: state.extra as BreakPageArgs,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BreakCubit(
        args.duration,
        args.referenceMode,
      )..startCountdown(),
      child: BlocListener<BreakCubit, BreakState>(
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
        child: WillPopScope(
          onWillPop: () async => false,
          child: const _BreakView(),
        ),
      ),
    );
  }
}

class _BreakView extends StatelessWidget {
  const _BreakView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          children: [
            StatusBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                gapH24,
                DisplayImage(),
                TimerFace(),
                ResumeButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BreakPageArgs {
  BreakPageArgs({required this.duration, required this.referenceMode});

  final Duration duration;
  final WorkMode referenceMode;
}
