import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';

class TranslationsProvider {
  final FilesystemService filesystem;

  List<Translation>? _translations;
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
          _translations = Translations.fromJson(json).data;
          _isLoaded = true;
          _isLoading = false;
          _reorder();
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
    return _translations ?? [];
  }

  bool get isLoaded => _isLoaded;
  bool get isLoading => _isLoading;

  void addTranslation(Translation translation) {
    if (_translations != null) {
      _translations!.add(translation);
    }
    _reorder();
  }

  void updateTranslation(Translation translation) {
    if (_translations == null) {
      return;
    }
    int index = _translations!.indexWhere(
        (t) => t.text.toLowerCase() == translation.text.toLowerCase());
    if (index >= 0) {
      _translations![index] = translation;
      _reorder();
    }
  }

  void _reorder() {
    if (_translations == null) {
      return;
    }
    _translations!.sort((a, b) {
      return DateTime.parse(b.dateOfLastTranslate)
          .compareTo(DateTime.parse(a.dateOfLastTranslate));
    });
  }
}
