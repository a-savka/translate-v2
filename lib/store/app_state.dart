import 'dart:convert';

import 'package:translate_1/store/skill_test/skill_test_state.dart';
import 'package:translate_1/store/translations/translations_state.dart';

class AppState {
  final TranslationsState translationsState;
  final SkillTestState skillTestState;

  AppState({
    required this.translationsState,
    required this.skillTestState,
  });

  factory AppState.initialState() {
    return AppState(
      translationsState: TranslationsState.initialState(),
      skillTestState: SkillTestState.initialState(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translationsState': translationsState.toJson(),
      'skillTestState': skillTestState.toJson(),
    };
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      translationsState: json['translationsState'] == null
          ? TranslationsState.initialState()
          : TranslationsState.fromJson(
              json['translationsState'] as Map<String, dynamic>),
      skillTestState: json['skillTestState'] == null
          ? SkillTestState.initialState()
          : SkillTestState.fromJson(
              json['skillTestState'] as Map<String, dynamic>),
    );
  }
}
