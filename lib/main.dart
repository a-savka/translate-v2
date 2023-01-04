import 'package:flutter/material.dart';
import 'package:layouts_1/main_navigation.dart';
import 'package:layouts_1/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _navigation = MainNavigation();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: _navigation.routes,
      initialRoute: MainNavigationRouteNames.home,
    );
  }
}
