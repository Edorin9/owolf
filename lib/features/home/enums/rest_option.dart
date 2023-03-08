import 'package:flutter/cupertino.dart';

enum RestOption { takeBreak, endSession, cancel }

extension RestOptionExt on RestOption {
  IconData? get icon {
    switch (this) {
      case RestOption.takeBreak:
        return CupertinoIcons.game_controller_solid;
      case RestOption.endSession:
        return CupertinoIcons.square_arrow_left_fill;
      case RestOption.cancel:
        return null;
    }
  }
}
