import 'package:flutter/material.dart';
import 'package:flutter_base/config/provider_config.dart';
import 'package:flutter_base/router/back_dispatcher.dart';
import 'package:flutter_base/router/router_delegate.dart';
import 'package:flutter_base/router/router_parser.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ProviderConfig.instance.getGlobal(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late RouterDelegateImpl delegate;
  late BackButtonDispatcherImpl backButtonDispatcherImpl;

  @override
  Widget build(BuildContext context) {
    delegate = context.read<RouterDelegateImpl>();
    backButtonDispatcherImpl = BackButtonDispatcherImpl(delegate);

    return ChangeNotifierProvider.value(
      value: delegate,
      child: MaterialApp.router(
        title: 'Navigation App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routeInformationParser: RouterParserImpl(),
        routerDelegate: delegate,
        backButtonDispatcher: backButtonDispatcherImpl,
      ),
    );
  }
}
