import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: CupertinoButton(
        onPressed: () => context.pop(),
        pressedOpacity: 0.5,
        child: const Icon(
          Icons.keyboard_backspace_rounded,
          color: Colors.black,
        ),
      ),
      title: Text(
        'Preferences',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
