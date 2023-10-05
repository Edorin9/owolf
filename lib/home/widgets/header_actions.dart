import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderActions extends StatelessWidget {
  const HeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ToggleButton(),
        _SettingsButton(),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => debugPrint('home'),
      child: Icon(
        CupertinoIcons.home,
        color: Colors.grey.shade900,
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => debugPrint('settings'),
      child: Icon(
        CupertinoIcons.settings,
        color: Colors.grey.shade900,
      ),
    );
  }
}
