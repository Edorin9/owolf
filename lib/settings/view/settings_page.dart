import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:utility/extensions.dart';

import '../../common/models/work_mode.dart';
import '../../common/widgets/black_snackbar.dart';
import '../cubit/cubit.dart';
import '../models/preference_value_type.dart';
import '../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = 'settings';
  static const routePath = '/settings';

  static GoRoute route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => const SettingsPage(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        settingsRepository: context.read<SettingsRepository>(),
      )..initState(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            _Content(),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.black,
          child: ListView(
            children: const [
              _Mode(),
              _Fluid(),
              _Periodic(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoButton(
          onPressed: () => context.pop(),
          pressedOpacity: 0.5,
          child: const Icon(
            Icons.keyboard_backspace_rounded,
            color: Colors.black,
          ),
        ),
        Text(
          'Preferences',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _Mode extends StatelessWidget {
  const _Mode();

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
        ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcATop),
          child: BlocSelector<SettingsCubit, SettingsState, WorkMode>(
            selector: (state) => state.timerMode,
            builder: (context, mode) {
              return RadioListTile.adaptive(
                onChanged: null,
                visualDensity: VisualDensity.compact,
                groupValue: mode,
                value: WorkMode.fluid,
                fillColor: MaterialStateProperty.all(Colors.black),
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
        ),
        ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcATop),
          child: BlocSelector<SettingsCubit, SettingsState, WorkMode>(
            selector: (state) => state.timerMode,
            builder: (context, mode) {
              return RadioListTile.adaptive(
                onChanged: null,
                visualDensity: VisualDensity.compact,
                groupValue: mode,
                value: WorkMode.periodic,
                fillColor: MaterialStateProperty.all(Colors.black),
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
        ),
      ],
    );
  }
}

class _Fluid extends StatefulWidget {
  const _Fluid();

  @override
  State<_Fluid> createState() => _FluidState();
}

class _FluidState extends State<_Fluid> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            const SectionHeader(title: 'Fluid (Flowtime)'),
            ListTile(
              title: const Text(
                'Break Length',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: DropdownButton<PreferenceValueType>(
                value: state.fluidBreakLengthType,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (type) => context
                    .read<SettingsCubit>()
                    .saveFluidBreakLength(type: type!),
                items: PreferenceValueType.values
                    .map<DropdownMenuItem<PreferenceValueType>>(
                        (PreferenceValueType value) {
                  return DropdownMenuItem<PreferenceValueType>(
                    value: value,
                    child: Text(value.nameText),
                  );
                }).toList(),
              ),
            ),
            state.fluidBreakLengthType == PreferenceValueType.defaultValue
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      '5-min break: 25 mins of work and below\n8-min break: more than 25 mins and less than 50 mins of work\n10-min break: more than 50 mins and less than 90 mins of work\n15-min break: more than 90 mins of work',
                      style: TextStyle(
                        color: Colors.black54,
                        height: 1.3,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            state.fluidBreakLengthType == PreferenceValueType.customValue
                ? Slider.adaptive(
                    value: state.fluidBreakLength,
                    min: 0,
                    max: 1,
                    divisions: 20,
                    thumbColor: Colors.black,
                    activeColor: Colors.black,
                    secondaryTrackValue: 0.5,
                    secondaryActiveColor: Colors.grey,
                    inactiveColor: Colors.grey.shade300,
                    label: '${(state.fluidBreakLength * 100).toInt()} %',
                    onChanged: (value) {
                      if (value > 0 && value <= 0.5) {
                        context
                            .read<SettingsCubit>()
                            .saveFluidBreakLength(value: value);
                      }
                    },
                  )
                : const SizedBox.shrink(),
            state.fluidBreakLengthType == PreferenceValueType.customValue
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                        '${(state.fluidBreakLength * 100).toInt()}% of rendered work time'),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}

class _Periodic extends StatefulWidget {
  const _Periodic();

  @override
  State<_Periodic> createState() => _PeriodicState();
}

class _PeriodicState extends State<_Periodic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'Periodic (Pomodoro)'),
        BlocSelector<SettingsCubit, SettingsState, double>(
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
        ),
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
                '${breakLengthPerPeriod.toInt()} minute${breakLengthPerPeriod > 1 ? 's' : ''} / period ${breakLengthPerPeriod == 5 ? '(Default)' : ''}',
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
              min: 1,
              max: 60,
              divisions: 59,
              thumbColor: Colors.black,
              activeColor: Colors.black,
              inactiveColor: Colors.grey.shade300,
              label: breakLengthPerPeriod.toInt().toString(),
              onChanged: (breakLength) => context
                  .read<SettingsCubit>()
                  .savePeriodBreakLength(breakLength),
            );
          },
        )
      ],
    );
  }
}
