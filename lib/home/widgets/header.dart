import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/constants.dart';

import '../../common/models/work_mode.dart';
import '../../common/widgets/black_snackbar.dart';
import '../../settings/view/settings_page.dart';
import '../cubit/home_cubit.dart';
import 'toggle_mode_dialog.dart';

class Header extends StatelessWidget {
  const Header({super.key});

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
            : BlackSnackbar.show(
                context,
                text: "You can't change modes while the timer is running.",
              );
      },
      pressedOpacity: 0.5,
      minSize: 0,
      child: BlocSelector<HomeCubit, HomeState, WorkMode>(
        selector: (state) => state.mode,
        builder: (context, mode) {
          return Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: Icon(
                  switch (mode) {
                    WorkMode.fluid => Icons.timer_rounded,
                    WorkMode.periodic => Icons.hourglass_top_rounded,
                  },
                  key: ValueKey<WorkMode>(mode),
                  color: Colors.black,
                ),
              ),
              hSpace8,
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.2, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: SizedBox(
                  key: ValueKey<WorkMode>(mode),
                  width: 75,
                  child: Text(
                    switch (mode) {
                      WorkMode.fluid => 'Fluid',
                      WorkMode.periodic => 'Periodic',
                    },
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
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
      onPressed: () {
        context.read<HomeCubit>().state.status == HomeStateStatus.running
            ? BlackSnackbar.show(
                context,
                text:
                    "You can't change your preferences while the timer is running.",
              )
            : _handleNavigationToSettings(context);
      },
      pressedOpacity: 0.5,
      child: const Icon(
        Icons.settings_input_component_rounded,
        color: Colors.black,
      ),
    );
  }

  void _handleNavigationToSettings(BuildContext context) async {
    await context.pushNamed(SettingsPage.routeName);
    if (context.mounted) context.read<HomeCubit>().initState();
  }
}
