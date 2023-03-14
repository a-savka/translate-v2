import 'package:flutter/widgets.dart';
import 'package:translate_1/pages/home_page.dart';
import 'package:translate_1/pages/page_one.dart';
import 'package:translate_1/pages/page_two.dart';
import 'package:translate_1/pages/skill_test_page.dart';

abstract class MainNavigationRouteNames {
  static const home = '/';
  static const skillTest = '/skill_test';
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
      title: 'Skill Test',
      route: MainNavigationRouteNames.skillTest,
    ),
  ];

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.home: (_) => const HomePage(),
    MainNavigationRouteNames.skillTest: (_) => const SkillTestPage(),
    MainNavigationRouteNames.page1: (_) => const PageOne(),
    MainNavigationRouteNames.page2: (_) => const PageTwo(),
  };
}
