import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/break_cubit.dart';

class StatusBackground extends StatelessWidget {
  const StatusBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BreakCubit, BreakState, bool>(
      selector: (state) => state.status == BreakStateStatus.completed,
      builder: (context, isCompleted) {
        return Container(
          color: isCompleted
              ? Colors.red.shade900
              : Theme.of(context).scaffoldBackgroundColor,
        );
      },
    );
  }
}
