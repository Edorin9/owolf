import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/constants.dart';

import '../../common/models/work_mode.dart';
import '../cubit/home_cubit.dart';

class StatusTexts extends StatelessWidget {
  const StatusTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p24,
      child: BlocSelector<HomeCubit, HomeState, bool>(
        selector: (state) => state.mode == WorkMode.periodic,
        builder: (context, isPeriodic) => AnimatedSwitcher(
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
          child: isPeriodic ? const _PeriodStatus() : const SizedBox.shrink(),
        ),
        // AnimatedOpacity(
        //   duration: const Duration(milliseconds: 150),
        //   curve: Curves.slowMiddle,
        //   opacity: isPeriodic ? 1 : 0,
        //   child: const _PeriodStatus(),
        // ),
      ),
    );
  }
}

class _PeriodStatus extends StatelessWidget {
  const _PeriodStatus();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, int>(
      selector: (state) => state.period,
      builder: (context, period) {
        return Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: '$period ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'period${period == 1 ? '' : 's'} completed',
              ),
            ],
          ),
        );
      },
    );
  }
}
