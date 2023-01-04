import 'package:flutter/widgets.dart';
import 'package:layouts_1/pages/home_page.dart';
import 'package:layouts_1/pages/page_one.dart';
import 'package:layouts_1/pages/page_two.dart';

abstract class MainNavigationRouteNames {
  static const home = '/';
  static const page1 = 'page_1';
  static const page2 = 'page_2';
}

class SideNavItem {
  final String route;
  final String title;
  const SideNavItem({
    required this.route,
    required this.title,
  });
}

class MainNavigation {
  static const List<SideNavItem> sideNav = [
    SideNavItem(
      title: 'Home',
      route: MainNavigationRouteNames.home,
    ),
    SideNavItem(
      title: 'Page 1',
      route: MainNavigationRouteNames.page1,
    ),
    SideNavItem(
      title: 'Page 2',
      route: MainNavigationRouteNames.page2,
    ),
  ];

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.home: (_) => const HomePage(),
    MainNavigationRouteNames.page1: (_) => const PageOne(),
    MainNavigationRouteNames.page2: (_) => const PageTwo(),
  };
}
