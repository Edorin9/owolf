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
        theme: ThemeData(primarySwatch: _blackMaterialColor),
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

const _blackColor = Color(0xff000000);
const _blackMaterialColor = MaterialColor(
  0xff000000,
  <int, Color>{
    50: _blackColor,
    100: _blackColor,
    200: _blackColor,
    300: _blackColor,
    400: _blackColor,
    500: _blackColor,
    600: _blackColor,
    700: _blackColor,
    800: _blackColor,
    900: _blackColor,
  },
);
