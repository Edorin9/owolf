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
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Icon(
              switch (mode) {
                WorkMode.fluid => Icons.timer_rounded,
                WorkMode.periodic => Icons.hourglass_top_rounded,
              },
              key: ValueKey<WorkMode>(mode),
              color: Colors.black,
            ),
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
