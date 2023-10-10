import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_repository/settings_repository.dart';

import 'break/view/break_page.dart';
import 'home/view/home_page.dart';
import 'settings/view/settings_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => SettingsRepository(_sharedPreferences),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          primarySwatch: MaterialColor(
            Colors.black.value,
            <int, Color>{
              50: Colors.black.withAlpha(5),
              100: Colors.black.withAlpha(25),
              200: Colors.black.withAlpha(50),
              300: Colors.black.withAlpha(75),
              400: Colors.black.withAlpha(100),
              500: Colors.black.withAlpha(125),
              600: Colors.black.withAlpha(150),
              700: Colors.black.withAlpha(200),
              800: Colors.black.withAlpha(225),
              900: Colors.black.withAlpha(255),
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouter(
          routes: [
            HomePage.route,
            BreakPage.route,
            SettingsPage.route,
          ],
        ),
      ),
    );
  }
}
