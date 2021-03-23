import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/pages/home/home_page.dart';
import 'package:flutter_base/pages/splash/splash_page.dart';
import 'package:flutter_base/router/router_config.dart';
import 'package:flutter_base/router/router_result_model.dart';

class RouterDelegateImpl extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<MaterialPage> _pages = [];

  List<MaterialPage> get pages => List.unmodifiable(_pages);

  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments as PageConfiguration;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  RouterDelegateImpl() {
    _pages.add(_createPage(SplashPage(), SplashPageConfig));
  }

  RouterResultModel? _resultModel;

  void setRouterResultModel(RouterResultModel model) {
    this._resultModel = model;
  }

  bool _onPopPage(Route<dynamic> route, result) {
    if (result != null) {
      _resultModel?.update(result);
    }

    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    _pages.remove(route.settings);

    notifyListeners();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: List.of(_pages),
    );
  }

  void _removePage(MaterialPage? page) {
    if (page != null) {
      _pages.remove(page);
    }
    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      _removePage(_pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  void _addPage(PageConfiguration pageConfig, {bool singleTop = true}) {
    if (singleTop &&
        pages.isNotEmpty &&
        (_pages.last.arguments as PageConfiguration).uiPage ==
            pageConfig.uiPage) {
      replace(pageConfig);
      return;
    }

    switch (pageConfig.uiPage) {
      case Pages.Splash:
        _addPageData(SplashPage(), SplashPageConfig);
        break;
      case Pages.Home:
        _addPageData(HomePage(), HomePageConfig);
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    _addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
    notifyListeners();
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute, {bool singleTop = true}) {
    _addPage(newRoute, singleTop: singleTop);
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
    notifyListeners();
  }

  void popResult(BuildContext context, dynamic result) {
    if (pages.length > 1) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    _pages.clear();
    _addPage(configuration);
    return SynchronousFuture(null);
  }

  MaterialPage _getPage(Pages routeName) {
    return _pages.lastWhere((element) =>
        (element.arguments as PageConfiguration).uiPage == routeName);
  }
}
