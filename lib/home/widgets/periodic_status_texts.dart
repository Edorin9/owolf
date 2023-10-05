import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/work_mode.dart';
import '../cubit/home_cubit.dart';

class PeriodicStatusTexts extends StatelessWidget {
  const PeriodicStatusTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, bool>(
      selector: (state) => state.mode == WorkMode.periodic,
      builder: (context, isPeriodic) =>
          isPeriodic ? const _RichPeriodStatusText() : const SizedBox(),
    );
  }
}

class _RichPeriodStatusText extends StatelessWidget {
  const _RichPeriodStatusText();

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
