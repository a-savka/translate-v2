import 'package:flutter/material.dart';
import 'package:layouts_1/layouts/default_layout.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Page 1',
      child: Text('This is page one.'),
    );
  }
}
