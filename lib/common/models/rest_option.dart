import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/cupertino.dart';

@MappableEnum()
enum RestOption {
  takeBreak,
  endSession,
  cancel;

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
