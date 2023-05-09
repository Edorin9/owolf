import 'package:flutter/material.dart';

import '../features/home/view/home_page.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.name,
      routes: routes,
    );
  }
}
