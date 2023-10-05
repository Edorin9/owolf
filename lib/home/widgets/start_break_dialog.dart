import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/home_cubit.dart';

class StartBreakDialog extends StatelessWidget {
  const StartBreakDialog({super.key});

  static Future<bool> show(BuildContext invokerContext) async {
    return await showDialog<bool>(
          context: invokerContext,
          builder: (context) => BlocProvider.value(
            value: invokerContext.read<HomeCubit>(),
            child: const StartBreakDialog(),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _RichMessageText(),
            SizedBox(height: 24),
            _StartBreakButton(),
            SizedBox(height: 4),
            _ContinueButton(),
          ],
        ),
      ),
    );
  }
}

class _RichMessageText extends StatelessWidget {
  const _RichMessageText();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, int>(
      selector: (state) => state.getBreakDuration().inMinutes,
      builder: (context, breakDuration) {
        return Text.rich(
          style: const TextStyle(fontSize: 16),
          TextSpan(
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

class _StartBreakButton extends StatelessWidget {
  const _StartBreakButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: Colors.lightGreen,
      onPressed: () => context.pop(true),
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

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => context.pop(false),
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
