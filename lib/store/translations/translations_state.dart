import 'package:translate_1/domain/models/translation.model.dart';

class TranslationsState {
  final List<Translation>? translations;
  final bool isLoading;
  TranslationsState({
    required this.translations,
    required this.isLoading,
  }) {
    if (translations != null) {
      translations!.sort((a, b) => DateTime.parse(b.dateOfLastTranslate)
          .compareTo(DateTime.parse(a.dateOfLastTranslate)));
    }
  }

  factory TranslationsState.initialState() {
    return TranslationsState(
      translations: null,
      isLoading: false,
    );
  }

  TranslationsState copyWith({
    List<Translation>? translations,
    bool? isLoading,
    bool resetTranslations = false,
  }) {
    return TranslationsState(
      translations:
          translations ?? (resetTranslations ? null : this.translations),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translations':
          translations?.map((translation) => translation.toJson()).toList(),
    };
  }

  factory TranslationsState.fromJson(Map<String, dynamic> json) {
    return TranslationsState(
      translations: json['translations'] == null
          ? null
          : (json['translations'] as List<dynamic>)
              .map((data) => Translation.fromJson(data))
              .toList(),
      isLoading: false,
    );
  }

  bool hasTranslations() {
    return translations != null;
  }
}
