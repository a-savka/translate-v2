import 'package:flutter/foundation.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/providers/translations.provider.dart';

class TranslationsViewModel extends ChangeNotifier {
  final TranslationsProvider translationsProvider;

  List<Translation>? translations;
  bool isLoading = false;
  bool isLoaded = false;

  TranslationsViewModel({
    required this.translationsProvider,
  });

  void loadData() async {
    isLoading = true;
    notifyListeners();
    try {
      translations = await translationsProvider.getTranslations();
      isLoaded = true;
    } catch (_) {}
    isLoading = false;
    notifyListeners();
  }
}
