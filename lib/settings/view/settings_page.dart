import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_repository/settings_repository.dart';

import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = 'settings';
  static const routePath = '/settings';

  static GoRoute route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => const SettingsPage(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        settingsRepository: context.read<SettingsRepository>(),
      )..initState(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            Content(),
          ],
        ),
      ),
    );
  }
}
