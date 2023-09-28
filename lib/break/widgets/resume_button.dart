import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../cubit/break_cubit.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      child: BlocSelector<BreakCubit, BreakState, bool>(
        selector: (state) => state.status == BreakStateStatus.completed,
        builder: (context, isCompleted) {
          return CupertinoButton(
            color: isCompleted ? Colors.white : Colors.black,
            disabledColor: Colors.grey.shade200,
            onPressed: () async {
              FlutterRingtonePlayer.stop();
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Resume work',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: isCompleted ? Colors.red.shade900 : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_double_arrow_right,
                  color: isCompleted ? Colors.red.shade900 : Colors.white,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
