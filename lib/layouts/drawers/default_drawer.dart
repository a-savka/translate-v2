import 'package:flutter/material.dart';
import 'package:layouts_1/main_navigation.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu'),
          ),
          ...MainNavigation.sideNav.map(
            (navItem) => ListTile(
              title: Text(navItem.title),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(navItem.route);
              },
            ),
          ),
        ],
      ),
    );
  }
}
