import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/constants.dart';

import '../../common/models/work_mode.dart';
import '../cubit/home_cubit.dart';

class ToggleModeDialog extends StatelessWidget {
  const ToggleModeDialog(this.invokerContext, this.mode, {super.key});

  final BuildContext invokerContext;
  final WorkMode mode;

  static Future<bool> show(BuildContext invokerContext, WorkMode mode) async {
    return await showDialog(
          context: invokerContext,
          builder: (context) => ToggleModeDialog(invokerContext, mode),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const _Title(),
            gapH12,
            _Message(mode: mode),
            gapH16,
            _Actions(invokerContext)
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Toggle Mode',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.mode});

  final WorkMode mode;

  @override
  Widget build(BuildContext context) {
    const boldTextStyle = TextStyle(fontWeight: FontWeight.bold);
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
        children: [
          const TextSpan(text: 'Do you want to switch timer mode from '),
          TextSpan(text: '${mode.name} ', style: boldTextStyle),
          const TextSpan(text: 'to '),
          TextSpan(text: mode.opposite.name, style: boldTextStyle),
          const TextSpan(text: '?'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions(this.invokerContext);

  final BuildContext invokerContext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _NoButton(),
        _YesButton(invokerContext),
      ],
    );
  }
}

class _NoButton extends StatelessWidget {
  const _NoButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p48,
        vertical: Sizes.p12,
      ),
      color: Colors.transparent,
      onPressed: () => context.pop(false),
      child: const Text(
        'No',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _YesButton extends StatelessWidget {
  const _YesButton(this.invokerContext);

  final BuildContext invokerContext;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p48,
        vertical: Sizes.p12,
      ),
      color: Colors.black,
      onPressed: () {
        invokerContext.read<HomeCubit>().toggleMode();
        context.pop();
      },
      child: const Text(
        'Yes',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
