import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:go_router/go_router.dart';

import '../../common/models/models.dart';
import '../cubit/break_cubit.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BreakCubit, BreakState, bool>(
      selector: (state) =>
          state.status == BreakStateStatus.completed ||
          state.referenceMode == WorkMode.fluid,
      builder: (context, isFluidModeOrBreakComplete) =>
          isFluidModeOrBreakComplete
              ? const _Button()
              : const SizedBox(width: double.infinity),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      child: BlocSelector<BreakCubit, BreakState, bool>(
        selector: (state) => state.status == BreakStateStatus.completed,
        builder: (context, isCompleted) => CupertinoButton(
          color: isCompleted ? Colors.white : Colors.black,
          disabledColor: Colors.grey.shade200,
          onPressed: () async {
            FlutterRingtonePlayer.stop();
            if (context.mounted) context.pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ButtonText(isCompleted),
              const SizedBox(width: 4),
              _ButtonIcon(isCompleted),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonText extends StatelessWidget {
  const _ButtonText(this.isCompleted);

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Resume work',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: isCompleted ? Colors.red.shade900 : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
    );
  }
}

class _ButtonIcon extends StatelessWidget {
  const _ButtonIcon(this.isCompleted);

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.keyboard_double_arrow_right,
      color: isCompleted ? Colors.red.shade900 : Colors.white,
    );
  }
}
