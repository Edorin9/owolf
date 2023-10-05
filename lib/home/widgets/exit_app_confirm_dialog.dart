import 'package:flutter/material.dart';

class ExitAppConfirmDialog extends StatelessWidget {
  const ExitAppConfirmDialog({super.key});

  static Future<bool> show(BuildContext invokerContext) async {
    return await showDialog(
          context: invokerContext,
          builder: (context) => const ExitAppConfirmDialog(),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to exit Owolf?'),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            side: const BorderSide(width: 2, color: Colors.black),
          ),
          child: const Text('No', style: TextStyle(color: Colors.black)),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(backgroundColor: Colors.black),
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
