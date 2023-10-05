import 'package:flutter/material.dart';

class CantChangeModeSnackbar {
  static void show(BuildContext invokerContext) {
    ScaffoldMessenger.of(invokerContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            "You can't change modes while the timer is running.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
  }
}
