import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/constants.dart';

import '../cubit/home_cubit.dart';

class StartBreakSheet extends StatelessWidget {
  const StartBreakSheet({super.key});

  static Future<bool?> show(BuildContext invokerContext) async {
    return await showModalBottomSheet<bool>(
      context: invokerContext,
      backgroundColor: Colors.white,
      shape: const Border(),
      isScrollControlled: true,
      builder: (context) => BlocProvider.value(
        value: invokerContext.read<HomeCubit>(),
        child: const StartBreakSheet(),
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const _Title(),
          vSpace2,
          const _Message(),
          vSpace16,
          _Buttons(context),
          vSpace8,
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Break Time!',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.black,
            fontSize: 18,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, int>(
      selector: (state) => state.breakDuration.inMinutes,
      builder: (context, breakDuration) {
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                ),
            children: [
              const TextSpan(text: "It's time for your "),
              TextSpan(
                text: '$breakDuration-minute ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: 'break!'),
            ],
          ),
        );
      },
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons(this.invokerContext);

  final BuildContext invokerContext;

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_ContinueButton(), hSpace8, _StartBreakButton()],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => context.pop(false),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      pressedOpacity: 0.5,
      child: const Text(
        'Continue working',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StartBreakButton extends StatelessWidget {
  const _StartBreakButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => context.pop(true),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      pressedOpacity: 0.5,
      color: Colors.black,
      child: const Text(
        'Start break',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
