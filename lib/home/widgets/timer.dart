import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/extensions.dart';

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
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) => Text(
              state.elapsedTime.timerFormat,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 81,
                    color: Colors.grey.shade900,
                  ),
            ),
          ),
          const SizedBox(height: 9),
          // play/stop button
          BlocSelector<HomeCubit, HomeState, HomeStateStatus>(
            selector: (state) => state.status,
            builder: (context, state) => CupertinoButton(
              onPressed: () async {
                final homeCubit = context.read<HomeCubit>();
                if (state == HomeStateStatus.idle) {
                  // start timer
                  homeCubit.initiateStopWatch();
                } else {
                  // show sheet to choose restOption
                  final restOption = await RestOptionSheet.show(context);
                  // handle chosen restOption
                  switch (restOption) {
                    case RestOption.takeBreak:
                      // // cancel break if computed break duration is zero or less
                      // if (homeBloc.state.breakDuration.inSeconds <= 0) {
                      //   if (context.mounted) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //         content: const Text('Time worked is not enough!'),
                      //         backgroundColor: Colors.red.shade900,
                      //       ),
                      //     );
                      //   }
                      //   return;
                      // }
                      homeCubit.resetStopwatch();
                      if (context.mounted) {
                        await context.pushNamed(
                          BreakPage.routeName,
                          extra: BreakPageArgs(
                            duration: homeCubit.state.breakDuration,
                            referenceMode: WorkMode.normal,
                          ),
                        );
                        homeCubit.initiateStopWatch();
                      }
                      break;
                    case RestOption.endSession:
                      homeCubit.resetStopwatch();
                      break;
                    case RestOption.cancel:
                      break;
                  }
                }
              },
              minSize: 0,
              child: Icon(
                state == HomeStateStatus.running
                    ? CupertinoIcons.stop_fill
                    : CupertinoIcons.play_arrow_solid,
                color: Colors.grey.shade900,
                size: 45,
              ),
            ),
          ),
          SizedBox(
            // TODO(Edorin9): future - remove
            height: MediaQuery.of(context).size.height / 9,
          ),
        ],
      ),
    );
  }
}
