import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/helpers.dart';

import '../../common/models/preference_value_type.dart';
import '../cubit/cubit.dart';
import 'section_header.dart';

class FluidSection extends StatelessWidget {
  const FluidSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Fluid'),
        _BreakLength(),
      ],
    );
  }
}

class _BreakLength extends StatelessWidget {
  const _BreakLength();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'Break Length',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing:
              BlocSelector<SettingsCubit, SettingsState, PreferenceValueType>(
            selector: (state) => state.fluidBreakLengthType,
            builder: (context, fluidBreakLengthType) {
              return DropdownButton<PreferenceValueType>(
                value: fluidBreakLengthType,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (type) {
                  context
                      .read<SettingsCubit>()
                      .saveFluidBreakLength(type: type);
                },
                items: PreferenceValueType.values
                    .map<DropdownMenuItem<PreferenceValueType>>(
                        (PreferenceValueType value) {
                  return DropdownMenuItem<PreferenceValueType>(
                    value: value,
                    child: Text(value.displayText),
                  );
                }).toList(),
              );
            },
          ),
        ),
        BlocSelector<SettingsCubit, SettingsState, PreferenceValueType>(
          selector: (state) => state.fluidBreakLengthType,
          builder: (context, fluidBreakLengthType) {
            return AnimatedSize(
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
                child: fluidBreakLengthType == PreferenceValueType.defaultValue
                    ? const _DefaultBreakLength()
                    : const _CustomBreakLength(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DefaultBreakLength extends StatelessWidget {
  const _DefaultBreakLength();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _CustomBreakLength extends StatefulWidget {
  const _CustomBreakLength();

  @override
  State<_CustomBreakLength> createState() => _CustomBreakLengthState();
}

class _CustomBreakLengthState extends State<_CustomBreakLength> {
  final _debouncer = Debouncer(milliseconds: 500);

  double _fluidBreakLengthValue = 0.2;

  @override
  void initState() {
    _fluidBreakLengthValue =
        context.read<SettingsCubit>().state.fluidBreakLength;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey(PreferenceValueType.customValue),
      children: [
        Slider.adaptive(
          value: _fluidBreakLengthValue,
          min: 0,
          max: 1,
          divisions: 20,
          thumbColor: Colors.black,
          activeColor: Colors.black,
          secondaryTrackValue: 0.5,
          secondaryActiveColor: Colors.grey,
          inactiveColor: Colors.grey.shade300,
          label: '${(_fluidBreakLengthValue * 100).toInt()} %',
          onChanged: (value) {
            if (value > 0 && value <= 0.5) {
              setState(() => _fluidBreakLengthValue = value);
              _debouncer.run(() => context
                  .read<SettingsCubit>()
                  .saveFluidBreakLength(value: value));
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
              '${(_fluidBreakLengthValue * 100).toInt()}% of rendered work time'),
        )
      ],
    );
  }
}
