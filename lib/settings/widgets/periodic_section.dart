import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/extensions.dart';

import '../../common/widgets/widgets.dart';
import '../cubit/cubit.dart';
import 'section_header.dart';

class PeriodicSection extends StatelessWidget {
  const PeriodicSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(title: 'Periodic'),
        _AlertSounds(),
        _PeriodLength(),
        _BreakLength(),
      ],
    );
  }
}

class _AlertSounds extends StatelessWidget {
  const _AlertSounds();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state.isPeriodAlertEnabled,
      builder: (context, isEnabled) {
        return SwitchListTile(
          onChanged: (isOn) =>
              context.read<SettingsCubit>().savePeriodAlert(isOn),
          value: isEnabled,
          title: const Text(
            'Alert sounds on period complete',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "${isEnabled ? 'Enabled' : 'Disabled'} quick tone ring when a period finishes",
            style: const TextStyle(color: Colors.black54),
          ),
        );
      },
    );
  }
}

class _PeriodLength extends StatelessWidget {
  const _PeriodLength();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, double>(
      selector: (state) => state.periodLength,
      builder: (context, periodLength) {
        return ListTile(
          title: const Text(
            'Period Length',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${periodLength.toInt()} minute${periodLength > 1 ? 's' : ''} ${periodLength == 25 ? '(Default)' : ''}',
            style: const TextStyle(color: Colors.black54),
          ),
          trailing: CupertinoButton(
            onPressed: () async {
              final duration = await showDurationPicker(
                    context: context,
                    initialTime: periodLength.minutes,
                  ) ??
                  0.minutes;
              debugPrint(duration.inMinutes.toString());
              if (context.mounted) {
                if (duration < 1.minutes) {
                  BlackSnackbar.show(
                    context,
                    text: 'Select at least 1 minute for period length.',
                  );
                } else {
                  final period = duration.inMinutes.toDouble();
                  context.read<SettingsCubit>().savePeriodLength(period);
                }
              }
            },
            color: Colors.black,
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(24),
            minSize: 0,
            pressedOpacity: 0.5,
            child: const Icon(
              Icons.punch_clock_rounded,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class _BreakLength extends StatelessWidget {
  const _BreakLength();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<SettingsCubit, SettingsState, double>(
          selector: (state) => state.periodicBreakLength,
          builder: (context, breakLengthPerPeriod) {
            return ListTile(
              title: const Text(
                'Break Length',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${breakLengthPerPeriod.toInt()} minute${breakLengthPerPeriod > 1 ? 's' : ''}/period ${breakLengthPerPeriod == 5 ? '(Default)' : ''}',
                style: const TextStyle(color: Colors.black54),
              ),
            );
          },
        ),
        BlocSelector<SettingsCubit, SettingsState, double>(
          selector: (state) => state.periodicBreakLength,
          builder: (context, breakLengthPerPeriod) {
            return Slider.adaptive(
              value: breakLengthPerPeriod,
              min: 0,
              max: 60,
              divisions: 60,
              thumbColor: Colors.black,
              activeColor: Colors.black,
              inactiveColor: Colors.grey.shade300,
              label: breakLengthPerPeriod.toInt().toString(),
              onChanged: (breakLength) {
                if (breakLength != 0) {
                  context
                      .read<SettingsCubit>()
                      .savePeriodBreakLength(breakLength);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
