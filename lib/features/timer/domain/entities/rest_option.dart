import 'package:flutter/cupertino.dart';

enum RestOption {
  takeBreak(icon: CupertinoIcons.game_controller_solid),
  endSession(icon: CupertinoIcons.square_arrow_left_fill),
  cancel();

  const RestOption({this.icon});

  final IconData? icon;
}
