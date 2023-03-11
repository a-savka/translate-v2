import 'dart:convert';

import 'package:translate_1/store/translations/translations_state.dart';

class AppState {
  final TranslationsState translationsState;

  AppState({
    required this.translationsState,
  });

  factory AppState.initialState() {
    return AppState(
      translationsState: TranslationsState.initialState(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translationsState': translationsState.toJson(),
    };
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      translationsState: TranslationsState.fromJson(
          json['translationsState'] as Map<String, dynamic>),
    );
  }
}
