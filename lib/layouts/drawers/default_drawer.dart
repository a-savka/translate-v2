import 'package:flutter/material.dart';
import 'package:translate_1/main_navigation.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Text(
              'Translator Menu',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          ...MainNavigation.sideNav.map(
            (navItem) => ListTile(
              title: Text(
                navItem.title,
                style: TextStyle(
                    color: _toDark(Theme.of(context).colorScheme.tertiary)),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(navItem.route);
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _toDark(Color source) {
    return source
        .withBlue(source.blue ~/ 1.3)
        .withGreen(source.green ~/ 1.3)
        .withRed(source.red ~/ 1.3);
  }
}
