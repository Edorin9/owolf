import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/extensions.dart';

import '../cubit/break_cubit.dart';

class TimerFace extends StatelessWidget {
  const TimerFace({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BreakCubit, BreakState,
        ({String formattedTime, bool isCompleted})>(
      selector: (state) => (
        formattedTime: state.remainingTime.timerFormat,
        isCompleted: state.status == BreakStateStatus.completed
      ),
      builder: (context, state) => Text(
        state.formattedTime,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 81,
              color: state.isCompleted ? Colors.white : Colors.grey.shade900,
            ),
      ),
    );
  }
}
