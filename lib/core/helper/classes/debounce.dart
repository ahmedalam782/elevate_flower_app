import 'dart:async';
import 'package:flutter/foundation.dart';

class Debounce {
  final Duration delay;
  Timer? _timer;

  Debounce({this.delay = const Duration(milliseconds: 500)});

  void call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}
