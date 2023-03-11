import 'package:flutter/material.dart';
import 'package:translate_1/layouts/default_layout.dart';
import 'package:translate_1/ui/translations/translations.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Home Page',
      child: TranslationsWidget(),
    );
  }
}
