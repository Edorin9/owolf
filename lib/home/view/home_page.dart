import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:utility/constants.dart';

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
      create: (context) => HomeCubit(
        settingsRepository: context.read<SettingsRepository>(),
      )..initState(),
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            previous.time != current.time &&
            current.mode == WorkMode.periodic &&
            current.status == HomeStateStatus.idle &&
            current.time == Duration.zero,
        listener: (context, state) async {
          final isPeriodAlertEnabled =
              context.read<SettingsRepository>().getPeriodAlert();
          if (isPeriodAlertEnabled == true) {
            FlutterRingtonePlayer().play(
              android: AndroidSounds.notification,
              ios: IosSounds.glass,
              asAlarm: false,
            );
          }
          if (ModalRoute.of(context)?.isCurrent == true) {
            final shouldStartBreak =
                await StartBreakSheet.show(context) ?? false;
            if (shouldStartBreak && context.mounted) {
              final homeCubit = context.read<HomeCubit>();
              homeCubit.stopTicks();
              await context.pushNamed(
                BreakPage.routeName,
                extra: BreakPageArgs(
                  duration: homeCubit.state.breakDuration,
                  referenceMode: WorkMode.periodic,
                ),
              );
              homeCubit
                ..resetTimer()
                ..startTimer();
            }
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: PopScope(
            onPopInvokedWithResult: (_, __) => ExitAppSheet.show(context),
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Header(),
                vSpace16,
                StatusTexts(),
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
