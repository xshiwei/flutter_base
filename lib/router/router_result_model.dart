import 'package:flutter/material.dart';
import 'package:flutter_base/utils/log_utils.dart';

class RouterResultModel with ChangeNotifier {
  HomeResult? _homeResult;

  HomeResult? get homeResult => _homeResult;

  void update(dynamic result) {
    LogUtils.d('update result: $result');

    switch (result.runtimeType) {
      case HomeResult:
        _homeResult = result;
        break;
      default:
        break;
    }
    notifyListeners();
  }
}

class HomeResult {
  final String title;

  const HomeResult(this.title);

  @override
  String toString() {
    return 'HomeResult{title: $title}';
  }
}
