import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'custom_bloc_observer.dart';

Future<void> bootstrap() async {
  _registerAppPrerunHandlers();
  runApp(const App());
}

void _registerAppPrerunHandlers() {
  // Initialize widgets binding
  WidgetsFlutterBinding.ensureInitialized();
  // Use custom bloc observer
  Bloc.observer = const CustomBlocObserver();
  // Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  // Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };
  // Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
