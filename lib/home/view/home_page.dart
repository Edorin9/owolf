import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:go_router/go_router.dart';

import '../../break/view/break_page.dart';
import '../../common/models/models.dart';
import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = 'home';
  static const routePath = '/';

  static GoRoute route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => const HomePage(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..initState(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          previous.time != current.time &&
          current.mode == WorkMode.periodic &&
          current.status == HomeStateStatus.idle &&
          current.time == Duration.zero,
      listener: (context, state) async {
        FlutterRingtonePlayer.play(
          android: AndroidSounds.notification,
          ios: IosSounds.glass,
          asAlarm: false,
        );
        if (ModalRoute.of(context)?.isCurrent == true) {
          final shouldStartBreak = await StartBreakDialog.show(context);
          if (shouldStartBreak && context.mounted) {
            final homeCubit = context.read<HomeCubit>();
            homeCubit.stopTicks();
            await context.pushNamed(
              BreakPage.routeName,
              extra: BreakPageArgs(
                duration: homeCubit.state.getBreakDuration(),
                referenceMode: WorkMode.periodic,
              ),
            );
            if (context.mounted) {
              homeCubit
                ..resetTimer()
                ..initTimer();
            }
          }
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
          onWillPop: () async => await _onWillPop(context),
          child: const Scaffold(
            body: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      HeaderActions(),
                      SizedBox(height: 16),
                      PeriodicStatusTexts(),
                      Timer(),
                    ],
                  ),
                ),
                ProxyTaskField(),
                // TODO(Edorin9): future - _DraggableTasksSheet(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit Owolf?'),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  side: const BorderSide(width: 2, color: Colors.black),
                ),
                child: const Text('No', style: TextStyle(color: Colors.black)),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: FilledButton.styleFrom(backgroundColor: Colors.black),
                child: const Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ) ??
        false;
  }
}
