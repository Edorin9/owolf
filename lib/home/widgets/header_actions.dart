import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';

import '../../common/models/work_mode.dart';
import '../cubit/home_cubit.dart';
import 'cant_change_mode_snackbar.dart';
import 'toggle_mode_dialog.dart';

class HeaderActions extends StatelessWidget {
  const HeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ToggleButton(),
        _SettingsButton(),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        final homeState = context.read<HomeCubit>().state;
        homeState.status == HomeStateStatus.idle
            ? ToggleModeDialog.show(context, homeState.mode)
            : CantChangeModeSnackbar.show(context);
      },
      child: BlocSelector<HomeCubit, HomeState, WorkMode>(
        selector: (state) => state.mode,
        builder: (context, mode) {
          return AnimatedCrossFade(
            crossFadeState: switch (mode) {
              WorkMode.fluid => CrossFadeState.showFirst,
              WorkMode.periodic => CrossFadeState.showSecond
            },
            firstChild: const Icon(
              Icons.timer_rounded,
              color: Colors.black,
            ),
            secondChild: const Icon(
              Icons.hourglass_top_rounded,
              color: Colors.black,
            ),
            duration: 500.ms,
          );
        },
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => debugPrint('settings'),
      child: const Icon(
        Icons.settings_input_component_rounded,
        color: Colors.black,
      ),
    );
  }
}
