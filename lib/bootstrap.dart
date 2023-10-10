import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_repository/settings_repository.dart';

import 'app.dart';
import 'custom_bloc_observer.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    App(sharedPreferences: sharedPreferences),
  );
}
