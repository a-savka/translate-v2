import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/ui/translations/translations.view_model.dart';
import 'package:translate_1/ui/translations/widgets/translations_list.dart';

class TranslationsWidget extends StatelessWidget {
  const TranslationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslationsViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!viewModel.isLoaded) {
          return Center(
            child: MaterialButton(
              onPressed: () {
                viewModel.loadData();
              },
              color: Colors.green,
              child: const Text(
                'Load Translations',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final List<Translation>? translations = viewModel.translations;
        if (translations == null || translations.isEmpty) {
          return const Center(
            child: Text('No translations available'),
          );
        }

        return TranslationsList(
          translations: translations,
        );
      },
    );
  }
}
