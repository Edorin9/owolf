import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/utility.dart';

import '../../break/view/break_page.dart';
import '../../common/models/models.dart';
import '../cubit/home_cubit.dart';
import 'rest_option_sheet.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: // TODO(Edorin9): future - remove
            MainAxisAlignment.center,
        children: [
          // TODO(Edorin9): future - add SizedBox(
          //   height: MediaQuery.of(context).size.height / 7,
          // ),
          // timer display
          const _TimeDisplay(),
          vSpace8,
          const _ControlButton(),
          SizedBox(
            // TODO(Edorin9): future - remove
            height: MediaQuery.of(context).size.height / 9,
          ),
        ],
      ),
    );
  }
}

class _TimeDisplay extends StatelessWidget {
  const _TimeDisplay();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, Duration>(
      selector: (state) => state.time,
      builder: (context, startTime) {
        return Text(
          startTime.timerFormat,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 81,
                color: Colors.grey.shade900,
              ),
        );
      },
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () async => _onPressed(context),
      pressedOpacity: 0.5,
      minSize: 0,
      child: BlocSelector<HomeCubit, HomeState, bool>(
        selector: (state) => state.status == HomeStateStatus.running,
        builder: (context, isRunning) => Icon(
          isRunning ? Icons.stop_circle_rounded : Icons.play_circle_rounded,
          color: Colors.grey.shade900,
          size: Sizes.p64,
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    final homeCubit = context.read<HomeCubit>();
    if (homeCubit.state.status == HomeStateStatus.idle) {
      // start timer
      homeCubit.startTimer();
    } else {
      // show sheet to choose restOption
      final restOption = await RestOptionSheet.show(context);
      // handle chosen restOption
      switch (restOption) {
        case RestOption.takeBreak:
          switch (homeCubit.state.mode) {
            case WorkMode.fluid:
              if (context.mounted) {
                homeCubit.resetTimer();
                await context.pushNamed(
                  BreakPage.routeName,
                  extra: BreakPageArgs(
                    duration: homeCubit.state.getBreakDuration(
                      fluidBreakLength: homeCubit.fluidBreakLength,
                    ),
                    referenceMode: WorkMode.fluid,
                  ),
                );
                homeCubit.startTimer();
              }
            case WorkMode.periodic:
              homeCubit.stopTicks();
              if (context.mounted) {
                await context.pushNamed(
                  BreakPage.routeName,
                  extra: BreakPageArgs(
                    duration: homeCubit.state.getBreakDuration(
                      breakLengthPerPeriod: homeCubit.breakLengthPerPeriod,
                    ),
                    referenceMode: WorkMode.periodic,
                  ),
                );
                homeCubit
                  ..resetTimer()
                  ..startTimer();
              }
          }

          break;
        case RestOption.endSession:
          homeCubit.resetTimer();
          break;
        case RestOption.cancel:
          break;
      }
    }
  }
}
