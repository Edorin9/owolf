import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'app_bloc_observer.dart';

Future<void> bootstrap() async {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      Bloc.observer = AppBlocObserver();
      FlutterError.onError = (details) {
        log(details.exceptionAsString(), stackTrace: details.stack);
      };
      runApp(const App());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
