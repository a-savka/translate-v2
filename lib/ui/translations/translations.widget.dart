import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/ui/translations/translations.view_model.dart';

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

        const Color tileColor = Color(0xFF3399FF);

        return ListView.builder(
          itemCount: translations.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: tileColor.withAlpha(0x30)),
                ),
                color: tileColor.withAlpha(0x10),
              ),
              child: Center(
                child: Text(
                  translations[index].text,
                  style: TextStyle(color: tileColor.withAlpha(0xB0)),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
