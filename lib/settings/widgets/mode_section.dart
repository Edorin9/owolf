import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/work_mode.dart';
import '../cubit/cubit.dart';
import 'section_header.dart';

class ModeSection extends StatelessWidget {
  const ModeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "Mode"),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.amber,
          child: Text(
            "You can change the timer mode from the main screen.",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.black, fontSize: 13, height: 1.2),
          ),
        ),
        BlocSelector<SettingsCubit, SettingsState, WorkMode>(
          selector: (state) => state.timerMode,
          builder: (context, mode) {
            return RadioListTile.adaptive(
              onChanged: null,
              visualDensity: VisualDensity.compact,
              groupValue: mode,
              value: WorkMode.fluid,
              fillColor: MaterialStateProperty.all(Colors.grey),
              title: const Text(
                'Fluid',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Flowtime',
                style: TextStyle(color: Colors.black54),
              ),
              secondary: const Icon(
                Icons.timer,
                color: Colors.black,
              ),
            );
          },
        ),
        BlocSelector<SettingsCubit, SettingsState, WorkMode>(
          selector: (state) => state.timerMode,
          builder: (context, mode) {
            return RadioListTile.adaptive(
              onChanged: null,
              visualDensity: VisualDensity.compact,
              groupValue: mode,
              value: WorkMode.periodic,
              fillColor: MaterialStateProperty.all(Colors.grey),
              title: const Text(
                'Periodic',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Pomodoro',
                style: TextStyle(color: Colors.black54),
              ),
              secondary: const Icon(
                Icons.hourglass_top_rounded,
                color: Colors.black,
              ),
            );
          },
        ),
      ],
    );
  }
}
