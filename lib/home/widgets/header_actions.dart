import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/work_mode.dart';
import '../cubit/home_cubit.dart';
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
      onPressed: () => ToggleModeDialog.show(
        context,
        context.read<HomeCubit>().state.mode,
      ),
      child: BlocSelector<HomeCubit, HomeState, WorkMode>(
        selector: (state) => state.mode,
        builder: (context, mode) {
          return Icon(
            switch (mode) {
              WorkMode.fluid => Icons.timer_rounded,
              WorkMode.periodic => Icons.hourglass_full_rounded
            },
            color: Colors.grey.shade900,
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
      child: Icon(
        Icons.settings_input_component_rounded,
        color: Colors.grey.shade900,
      ),
    );
  }
}
