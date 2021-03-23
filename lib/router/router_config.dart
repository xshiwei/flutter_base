const String SplashPath = '/splash';
const String HomePath = '/Home';
const String SettingPath = '/Setting';

enum Pages { Splash, Home, Setting }

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;

  const PageConfiguration({required this.key, required this.path, required this.uiPage});
}

const PageConfiguration SplashPageConfig =
    PageConfiguration(key: 'Splash', path: SplashPath, uiPage: Pages.Splash);

const PageConfiguration HomePageConfig =
    PageConfiguration(key: 'Home', path: HomePath, uiPage: Pages.Home);

const PageConfiguration SettingPageConfig =
    PageConfiguration(key: 'Setting', path: SettingPath, uiPage: Pages.Setting);
