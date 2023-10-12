import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/preference_value_type.dart';
import '../cubit/cubit.dart';
import 'section_header.dart';

class FluidSection extends StatelessWidget {
  const FluidSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Fluid'),
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
                    child: Text(value.displayText),
                  );
                }).toList(),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: state.fluidBreakLengthType ==
                        PreferenceValueType.defaultValue
                    ? Container(
                        key: const ValueKey(PreferenceValueType.defaultValue),
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: const Text(
                          '5 mins: <= 25 mins of work\n8 mins: > 25 mins and < 50 mins of work\n10 mins: > 50 mins and < 90 mins of work\n15 mins: > 90 mins of work',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black54,
                            height: 1.3,
                          ),
                        ),
                      )
                    : Column(
                        key: const ValueKey(PreferenceValueType.customValue),
                        children: [
                          Slider.adaptive(
                            value: state.fluidBreakLength,
                            min: 0,
                            max: 1,
                            divisions: 20,
                            thumbColor: Colors.black,
                            activeColor: Colors.black,
                            secondaryTrackValue: 0.5,
                            secondaryActiveColor: Colors.grey,
                            inactiveColor: Colors.grey.shade300,
                            label:
                                '${(state.fluidBreakLength * 100).toInt()} %',
                            onChanged: (value) {
                              if (value > 0 && value <= 0.5) {
                                context
                                    .read<SettingsCubit>()
                                    .saveFluidBreakLength(value: value);
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                                '${(state.fluidBreakLength * 100).toInt()}% of rendered work time'),
                          )
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
