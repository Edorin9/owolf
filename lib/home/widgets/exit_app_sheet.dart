import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utility/constants.dart';

class ExitAppSheet extends StatelessWidget {
  const ExitAppSheet({super.key});

  static Future<bool> show(BuildContext invokerContext) async {
    return await showModalBottomSheet<bool>(
          context: invokerContext,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          builder: (_) => const ExitAppSheet(),
        ) ??
        false;
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
      'Are you sure?',
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
    return Text(
      'Do you want to exit Owolf?',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.black,
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w300,
          ),
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
      children: [_NoButton(), hSpace16, _YesButton()],
    );
  }
}

class _NoButton extends StatelessWidget {
  const _NoButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => context.pop(false),
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 12,
      ),
      pressedOpacity: 0.5,
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
  const _YesButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => context.pop(true),
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 12,
      ),
      pressedOpacity: 0.5,
      color: Colors.black,
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
