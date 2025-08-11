import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/utility.dart';

import '../../common/models/models.dart';
import '../cubit/home_cubit.dart';

class RestOptionSheet extends StatelessWidget {
  const RestOptionSheet({super.key});

  static Future<RestOption> show(BuildContext invokerContext) async {
    return await showModalBottomSheet<RestOption>(
          context: invokerContext,
          backgroundColor: Colors.white,
          shape: const Border(),
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
    return const Wrap(
      children: [
        _DragHandle(),
        _Content(),
      ],
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          height: 3,
          width: 32,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final mode = context.read<HomeCubit>().state.mode;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          mode == WorkMode.fluid
              ? const _FluidMessage()
              : const _PeriodicMessage(),
          vSpace4,
          const _OptionsRow(),
        ],
      ),
    );
  }
}

class _FluidMessage extends StatelessWidget {
  const _FluidMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<HomeCubit, HomeState, bool>(
          selector: (state) => state.breakDuration >= 1.seconds,
          builder: (context, canTakeBreak) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.02, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: canTakeBreak
                ? const _TimeSufficientFluidMessage()
                : const _TimeDeficientFluidMessage(),
          ),
        ),
      ],
    );
  }
}

class _TimeSufficientFluidMessage extends StatefulWidget {
  const _TimeSufficientFluidMessage();

  @override
  State<_TimeSufficientFluidMessage> createState() =>
      _TimeSufficientFluidMessageState();
}

class _TimeSufficientFluidMessageState
    extends State<_TimeSufficientFluidMessage> {
  Duration lastBreakDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, Duration>(
      selector: (state) {
        // save the last breakDuration value to avoid 0 duration display
        // when session is ended and breakDuration calculates to zero
        final breakDuration = state.breakDuration == Duration.zero
            ? lastBreakDuration
            : state.breakDuration;
        lastBreakDuration = state.breakDuration;
        return breakDuration;
      },
      builder: (context, breakDuration) {
        log(breakDuration.inSeconds.toString());
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                ),
            children: [
              const TextSpan(text: 'Start '),
              TextSpan(
                text:
                    '${breakDuration < 1.minutes ? '${breakDuration.inSeconds}-second ' : '${breakDuration.inMinutes}-minute '}break ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: 'or '),
              const TextSpan(
                text: 'end session\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'Both options will drop the current period’s timer.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimeDeficientFluidMessage extends StatelessWidget {
  const _TimeDeficientFluidMessage();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.black,
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
        children: const [
          TextSpan(
            text: 'End session\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'This will drop the current period’s timer.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _PeriodicMessage extends StatelessWidget {
  const _PeriodicMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<HomeCubit, HomeState, bool>(
          selector: (state) => state.period > 0,
          builder: (context, hasPeriod) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.02, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: hasPeriod
                ? const _NonZeroPeriodMessage()
                : const _ZeroPeriodMessage(),
          ),
        ),
      ],
    );
  }
}

class _NonZeroPeriodMessage extends StatefulWidget {
  const _NonZeroPeriodMessage();

  @override
  State<_NonZeroPeriodMessage> createState() => _NonZeroPeriodMessageState();
}

class _NonZeroPeriodMessageState extends State<_NonZeroPeriodMessage> {
  Duration lastBreakDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, Duration>(
      selector: (state) {
        // save the last breakDuration value to avoid 0 duration display
        // when session is ended and breakDuration calculates to zero
        final breakDuration = state.breakDuration == Duration.zero
            ? lastBreakDuration
            : state.breakDuration;
        lastBreakDuration = state.breakDuration;
        return breakDuration;
      },
      builder: (context, breakDuration) {
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                ),
            children: [
              const TextSpan(text: 'Start '),
              TextSpan(
                text: '${breakDuration.inMinutes}-minute break ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: 'or '),
              const TextSpan(
                text: 'end session\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text:
                    'Both options will drop the current timer and all completed periods.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ZeroPeriodMessage extends StatelessWidget {
  const _ZeroPeriodMessage();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.black,
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
        children: const [
          TextSpan(
            text: 'End session\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'This will drop the current timer.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _OptionsRow extends StatelessWidget {
  const _OptionsRow();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, bool>(
      selector: (state) {
        final isTimeSufficient = state.breakDuration >= 1.seconds;
        final hasPeriod = state.period >= 1;
        return isTimeSufficient || hasPeriod;
      },
      builder: (context, isTimeSufficientOrHasPeriod) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.02, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: Row(
            key: ValueKey(isTimeSufficientOrHasPeriod),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isTimeSufficientOrHasPeriod
                  ? const _TakeBreakButton()
                  : const SizedBox.shrink(),
              isTimeSufficientOrHasPeriod
                  ? const _OrText()
                  : const SizedBox.shrink(),
              const _EndSessionButton(),
            ],
          ),
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
      onPressed: () => context.pop(RestOption.takeBreak),
      pressedOpacity: 0.5,
      child: Icon(
        RestOption.takeBreak.icon,
        color: Colors.black,
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
            color: Colors.black,
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
      onPressed: () => context.pop(RestOption.endSession),
      pressedOpacity: 0.5,
      child: Icon(
        RestOption.endSession.icon,
        color: Colors.black,
        size: 36,
      ),
    );
  }
}
