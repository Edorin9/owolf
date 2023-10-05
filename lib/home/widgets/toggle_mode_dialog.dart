import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    const boldTextStyle = TextStyle(fontWeight: FontWeight.bold);
    return Dialog(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Toggle Mode', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                      text: 'Do you want to switch timer mode from '),
                  TextSpan(text: '${mode.name} ', style: boldTextStyle),
                  const TextSpan(text: 'to '),
                  TextSpan(text: mode.opposite.name, style: boldTextStyle),
                  const TextSpan(text: '?'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                  minSize: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  color: Colors.transparent,
                  onPressed: () => context.pop(false),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CupertinoButton(
                  minSize: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
