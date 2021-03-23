import 'package:flutter/cupertino.dart';
import 'package:flutter_base/router/router_delegate.dart';
import 'package:flutter_base/utils/log_utils.dart';

class BackButtonDispatcherImpl extends RootBackButtonDispatcher {
  final RouterDelegateImpl _routerDelegate;

  DateTime? _lassPressedAt;

  BackButtonDispatcherImpl(this._routerDelegate) : super();

  @override
  Future<bool> didPopRoute() async {
    LogUtils.d('didPopRoute: ${_routerDelegate.pages.length}');

    if (_routerDelegate.pages.length == 1) {
      if (_lassPressedAt == null ||
          (DateTime.now().difference(_lassPressedAt!) > Duration(seconds: 2))) {
        _lassPressedAt = DateTime.now();
        LogUtils.d('再按一次');
        return true;
      }
      return false;
    } else {
      return _routerDelegate.popRoute();
    }
  }
}
