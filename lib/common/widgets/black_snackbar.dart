import 'package:flutter/material.dart';

class BlackSnackbar {
  static void show(BuildContext invokerContext, {required String text}) {
    ScaffoldMessenger.of(invokerContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            text,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      );
  }
}
