import 'package:flutter/material.dart';
import 'package:layouts_1/layouts/drawers/default_drawer.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const DefaultLayout({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: const DefaultDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
