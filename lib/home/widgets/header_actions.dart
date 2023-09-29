import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderActions extends StatelessWidget {
  const HeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoButton(
          onPressed: () => debugPrint('home'),
          child: Icon(
            CupertinoIcons.home,
            color: Colors.grey.shade900,
          ),
        ),
        CupertinoButton(
          onPressed: () => debugPrint('settings'),
          child: Icon(
            CupertinoIcons.settings,
            color: Colors.grey.shade900,
          ),
        ),
      ],
    );
  }
}
