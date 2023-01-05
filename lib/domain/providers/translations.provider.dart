import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';

class TranslationsProvider {
  final FilesystemService filesystem;

  List<Translation>? translations;
  bool _isLoaded = false;
  bool _isLoading = false;

  TranslationsProvider({
    required this.filesystem,
  });

  Future<void> _loadTranslations() async {
    if (isLoading) {
      return;
    }

    _isLoading = true;

    try {
      final path = await filesystem.pickFilePath();
      if (path != null) {
        final json = await filesystem.readJsonFile(path);
        if (json != null) {
          translations = Translations.fromJson(json).data;
          _isLoaded = true;
          _isLoading = false;
        }
      }
    } catch (_) {
      _isLoading = false;
      rethrow;
    }
  }

  Future<List<Translation>> getTranslations() async {
    if (!_isLoaded) {
      await _loadTranslations();
    }
    return translations ?? [];
  }

  bool get isLoaded => _isLoaded;
  bool get isLoading => _isLoading;
}
