import 'package:flutter/cupertino.dart';

class LogUtils {
  static final bool _isDebug = true;

  static const String _TAG = 'xsw';

  static void d(String log) {
    if (_isDebug) {
      debugPrint('$_TAG:  $log');
    }
  }
}
