import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'break/view/break_page.dart';
import 'home/view/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        routes: [
          HomePage.route,
          BreakPage.route,
        ],
      ),
    );
  }
}
