import 'package:flutter/material.dart';
import 'package:translate_1/layouts/drawers/default_drawer.dart';

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
        title: Text(title),
      ),
      drawer: const DefaultDrawer(),
      body: child,
    );
  }
}
