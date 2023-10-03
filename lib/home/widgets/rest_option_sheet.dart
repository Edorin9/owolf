import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/models/models.dart';
import '../cubit/home_cubit.dart';

class RestOptionSheet extends StatelessWidget {
  const RestOptionSheet({super.key});

  static Future<RestOption> show(BuildContext invokerContext) async {
    return await showModalBottomSheet<RestOption>(
          context: invokerContext,
          isScrollControlled: true,
          builder: (context) => BlocProvider.value(
            value: invokerContext.read<HomeCubit>(),
            child: const RestOptionSheet(),
          ),
        ) ??
        RestOption.cancel;
  }

  @override
  Widget build(BuildContext context) {
    final mode = context.read<HomeCubit>().state.mode;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 16),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              mode == WorkMode.fluid
                  ? const _FluidMessageText()
                  : const _PeriodicMessageText(),
              const SizedBox(height: 5),
              const _OptionsRow(),
            ],
          ),
        ],
      ),
    );
  }
}

class _FluidMessageText extends StatelessWidget {
  const _FluidMessageText();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, int>(
      selector: (state) => state.getBreakDuration().inMinutes,
      builder: (context, breakDuration) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.grey.shade900,
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.w300,
              ),
          children: [
            const TextSpan(text: 'Do you want to take a '),
            // ignore: lines_longer_than_80_chars
            TextSpan(
              text:
                  'break for $breakDuration minute${breakDuration > 1 ? 's' : ''} ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: 'or '),
            const TextSpan(
              text: 'end this session?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodicMessageText extends StatelessWidget {
  const _PeriodicMessageText();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<HomeCubit, HomeState, int>(
          selector: (state) => state.period,
          builder: (context, period) => period == 0
              ? RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.grey.shade900,
                          fontSize: 18,
                          height: 1.5,
                          fontWeight: FontWeight.w300,
                        ),
                    children: const [
                      TextSpan(
                        text:
                            'Do you want to drop current period’s progress and ',
                      ),
                      TextSpan(
                        text: 'end session',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '?'),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => state.period > 0
              ? RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.grey.shade900,
                          fontSize: 18,
                          height: 1.5,
                          fontWeight: FontWeight.w300,
                        ),
                    children: [
                      const TextSpan(text: 'Do you want to start a '),
                      TextSpan(
                        text: '${state.getBreakDuration().inMinutes}-minute ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                          text: 'break and drop current period’s progress or '),
                      const TextSpan(
                        text: 'end whole session?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

class _OptionsRow extends StatelessWidget {
  const _OptionsRow();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, bool>(
      selector: (state) => state.mode == WorkMode.fluid || state.period >= 1,
      builder: (context, isFluidOrHasPeriod) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isFluidOrHasPeriod ? const _TakeBreakButton() : const SizedBox(),
            isFluidOrHasPeriod ? const _OrText() : const SizedBox(),
            const _EndSessionButton(),
          ],
        );
      },
    );
  }
}

class _TakeBreakButton extends StatelessWidget {
  const _TakeBreakButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      // stop normal timer - start break countdown timer
      onPressed: () => context.pop(RestOption.takeBreak),
      child: Icon(
        RestOption.takeBreak.icon,
        color: Colors.grey.shade900,
        size: 36,
      ),
    );
  }
}

class _OrText extends StatelessWidget {
  const _OrText();

  @override
  Widget build(BuildContext context) {
    return Text(
      '— OR —',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.grey.shade900,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _EndSessionButton extends StatelessWidget {
  const _EndSessionButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      // stop normal timer
      onPressed: () => context.pop(RestOption.endSession),
      child: Icon(
        RestOption.endSession.icon,
        color: Colors.grey.shade900,
        size: 36,
      ),
    );
  }
}
