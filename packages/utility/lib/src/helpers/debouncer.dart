import 'dart:async';
import 'dart:ui';

import 'package:utility/extensions.dart';

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(milliseconds.milliseconds, action);
  }
}
