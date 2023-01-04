import 'package:flutter/material.dart';
import 'package:layouts_1/layouts/default_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Home Page',
      child: Text('This is main page'),
    );
  }
}
