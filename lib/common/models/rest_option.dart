import 'package:flutter/cupertino.dart';

/// Options to choose when interacting with a running timer
/// 
enum RestOption {
  /// Start break timer.
  /// 
  takeBreak,

  /// Stop the timer for good.
  /// 
  endSession,

  /// Do nothing - close sheet.
  /// 
  cancel;

  /// Corresponding icon of a [RestOption]. (for UI use)
  /// 
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
