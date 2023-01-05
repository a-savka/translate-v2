import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/providers/translations.provider.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';
import 'package:translate_1/layouts/default_layout.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/ui/translations/translations.view_model.dart';
import 'package:translate_1/ui/translations/translations.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Home Page',
      child: ChangeNotifierProvider<TranslationsViewModel>(
        create: (_) => TranslationsViewModel(
          translationsProvider: getIt.get<TranslationsProvider>(),
        ),
        child: const TranslationsWidget(),
      ),
    );
  }
}
