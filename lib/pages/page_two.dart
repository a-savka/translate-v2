import 'package:flutter/widgets.dart';
import 'package:layouts_1/layouts/default_layout.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Page 2',
      child: Text('This is Page two'),
    );
  }
}
