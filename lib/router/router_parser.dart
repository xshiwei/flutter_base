import 'package:flutter/cupertino.dart';
import 'package:flutter_base/router/router_config.dart';
import 'package:flutter_base/utils/log_utils.dart';

class RouterParserImpl extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    LogUtils.d('parseRouteInformation');
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return SplashPageConfig;
    }

    final path = uri.pathSegments[0];
    switch (path) {
      case SplashPath:
        return SplashPageConfig;
      case HomePath:
        return HomePageConfig;
      case SettingPath:
        return SettingPageConfig;
      default:
        return SplashPageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    LogUtils.d('restoreRouteInformation');
    switch (configuration.uiPage) {
      case Pages.Splash:
        return const RouteInformation(location: SplashPath);
      case Pages.Home:
        return const RouteInformation(location: HomePath);
      case Pages.Setting:
        return const RouteInformation(location: SettingPath);
      default:
        return const RouteInformation(location: SplashPath);
    }
  }
}
