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
      child: BlocListener<HomeCubit, HomeState>(
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
                  ..startTimer();
              }
            }
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: WillPopScope(
            onWillPop: () async => ExitAppConfirmDialog.show(context),
            child: const _HomeView(),
          ),
        ),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
    );
  }
}
