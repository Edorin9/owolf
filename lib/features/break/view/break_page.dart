import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/extensions/duration_ext.dart';
import '../../home/enums/work_mode.dart';
import '../bloc/break_bloc.dart';

class BreakPage extends StatelessWidget {
  const BreakPage({super.key});

  static const String name = '/break';
  static WidgetBuilder route() => (context) => const BreakPage();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments! as BreakArgs;
    return BlocProvider(
      create: (context) => BreakBloc(args.duration, args.referenceMode),
      child: const _BreakView(),
    );
  }
}

class _BreakView extends StatelessWidget {
  const _BreakView();

  @override
  Widget build(BuildContext context) {
    // start countdown
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<BreakBloc>().add(const CountdownInititated()),
    );
    // view layout
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<BreakBloc, BreakState>(
              builder: (context, state) => Text(
                state.remainingTime.timerFormat,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 81,
                      color: Colors.grey.shade900,
                    ),
              ),
            ),
            Text(
              'Text test',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.grey.shade900,
                    fontSize: 18,
                    height: 1.5,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreakArgs {
  BreakArgs({
    required this.duration,
    required this.referenceMode,
  });

  final Duration duration;
  final WorkMode referenceMode;
}
