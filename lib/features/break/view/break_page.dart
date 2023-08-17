import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../../util/extensions/duration_ext.dart';
import '../../home/enums/work_mode.dart';
import '../bloc/break_bloc.dart';

class BreakPage extends StatelessWidget {
  const BreakPage({super.key});

  static const String name = '/break';
  static WidgetBuilder route() => (context) => const BreakPage();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments! as BreakArgs;
    return BlocProvider(
      create: (context) => BreakBloc(args.duration, args.referenceMode),
      child: const _BreakView(),
    );
  }
}

class _BreakView extends StatelessWidget {
  const _BreakView();

  @override
  Widget build(BuildContext context) {
    // start countdown
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<BreakBloc>().initiateCountdown(),
    );
    // view layout
    return BlocBuilder<BreakBloc, BreakState>(
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
                BlocBuilder<BreakBloc, BreakState>(
                  builder: (context, state) {
                    return Image.asset(
                      'assets/coffee.png',
                      height: 163,
                      color: state.isFinished ? Colors.white : Colors.black,
                      colorBlendMode: BlendMode.srcATop,
                    );
                  },
                ),
                BlocBuilder<BreakBloc, BreakState>(
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
                    onPressed: () {
                      if (state.isFinished) FlutterRingtonePlayer.stop();
                      Navigator.of(context).pop();
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

class BreakArgs {
  BreakArgs({
    required this.duration,
    required this.referenceMode,
  });

  final Duration duration;
  final WorkMode referenceMode;
}
