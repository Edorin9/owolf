import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/utility.dart';

import '../../common/models/models.dart';
import '../cubit/home_cubit.dart';

class ToggleModeSheet extends StatelessWidget {
  const ToggleModeSheet({super.key});

  static Future<bool?> show(BuildContext invokerContext) async {
    return await showModalBottomSheet<bool>(
      context: invokerContext,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) => BlocProvider.value(
        value: invokerContext.read<HomeCubit>(),
        child: const ToggleModeSheet(),
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
    final mode = context.read<HomeCubit>().state.mode;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const _Title(),
          vSpace2,
          _Message(mode: mode),
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
      'Toggle Mode',
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
  const _Message({required this.mode});

  final WorkMode mode;

  @override
  Widget build(BuildContext context) {
    const boldTextStyle = TextStyle(fontWeight: FontWeight.bold);
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
          const TextSpan(text: 'Do you want to switch timer mode from '),
          TextSpan(text: '${mode.name} ', style: boldTextStyle),
          const TextSpan(text: 'to '),
          TextSpan(text: mode.opposite.name, style: boldTextStyle),
          const TextSpan(text: '?'),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons(this.invokerContext);

  final BuildContext invokerContext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [const _NoButton(), hSpace16, _YesButton(invokerContext)],
    );
  }
}

class _NoButton extends StatelessWidget {
  const _NoButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => context.pop(false),
      minSize: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 12,
      ),
      color: Colors.transparent,
      pressedOpacity: 0.5,
      child: const Text(
        'No',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
      onPressed: () {
        invokerContext.read<HomeCubit>().toggleMode();
        context.pop();
      },
      minSize: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 12,
      ),
      color: Colors.black,
      pressedOpacity: 0.5,
      child: const Text(
        'Yes',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
