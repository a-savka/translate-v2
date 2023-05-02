import 'package:flutter/material.dart';
import 'package:translate_1/layouts/drawers/default_drawer.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? menuItems;

  const DefaultLayout({
    Key? key,
    required this.child,
    required this.title,
    this.menuItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: menuItems == null
            ? null
            : [
                MenuAnchor(
                  menuChildren: menuItems!,
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                    );
                  },
                )
              ],
      ),
      drawer: const DefaultDrawer(),
      body: child,
    );
  }
}
