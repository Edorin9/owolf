import 'package:common/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../home/models/work_mode.dart';
import '../cubit/break_cubit.dart';


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
    // view layout
    return BlocBuilder<BreakCubit, BreakState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state.isFinished
              ? Colors.red.shade900
              : Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 27),
                BlocBuilder<BreakCubit, BreakState>(
                  builder: (context, state) {
                    return Image.asset(
                      'assets/coffee.png',
                      height: 163,
                      color: state.isFinished ? Colors.white : Colors.black,
                      colorBlendMode: BlendMode.srcATop,
                    );
                  },
                ),
                BlocBuilder<BreakCubit, BreakState>(
                  builder: (context, state) => Text(
                    state.remainingTime.timerFormat,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 81,
                          color: state.isFinished
                              ? Colors.white
                              : Colors.grey.shade900,
                        ),
                  ),
                ),
                // Text(
                //   'Text test',
                //   style: Theme.of(context).textTheme.displayLarge?.copyWith(
                //         color: Colors.grey.shade900,
                //         fontSize: 18,
                //         height: 1.5,
                //         fontWeight: FontWeight.w300,
                //       ),
                // ),
                Container(
                  padding: const EdgeInsets.all(18),
                  width: double.infinity,
                  child: CupertinoButton(
                    color: state.isFinished ? Colors.white : Colors.black,
                    disabledColor: Colors.grey.shade200,
                    onPressed: () async {
                      (state.isFinished)
                          ? FlutterRingtonePlayer.stop()
                          : await context.read<BreakCubit>().stopCountdown();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Resume work',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: state.isFinished
                                    ? Colors.red.shade900
                                    : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_double_arrow_right,
                          color: state.isFinished
                              ? Colors.red.shade900
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
