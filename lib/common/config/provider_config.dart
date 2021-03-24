import 'package:flutter/cupertino.dart';
import 'package:flutter_base/common/router/router_delegate.dart';
import 'package:flutter_base/common/router/router_result_model.dart';
import 'package:provider/provider.dart';

class ProviderConfig {
  factory ProviderConfig() => _instance;

  static final ProviderConfig _instance = ProviderConfig._internal();

  static ProviderConfig get instance => _instance;

  ProviderConfig._internal();

  getGlobal({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouterResultModel()),
        ChangeNotifierProxyProvider<RouterResultModel, RouterDelegateImpl>(
          create: (_) => RouterDelegateImpl(),
          update: (_, result, delegate) =>
              delegate!..setRouterResultModel(result),
        )
      ],
      child: child,
    );
  }
}
