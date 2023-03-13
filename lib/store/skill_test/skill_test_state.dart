import 'package:translate_1/domain/models/translation.model.dart';

class SkillTestState {
  final List<Translation> translations;
  final int correctAnswers;
  final int wrongAnswers;
  final bool isDone;
  SkillTestState({
    required this.translations,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.isDone,
  });

  factory SkillTestState.initialState() {
    return SkillTestState(
      translations: [],
      correctAnswers: 0,
      wrongAnswers: 0,
      isDone: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translations':
          translations.map((translation) => translation.toJson()).toList(),
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'isDone': isDone,
    };
  }

  factory SkillTestState.fromJson(Map<String, dynamic> json) {
    return SkillTestState(
      translations: (json['translations'] as List<dynamic>)
          .map((data) => Translation.fromJson(data))
          .toList(),
      correctAnswers: json['correctAnswers'] as int,
      wrongAnswers: json['wrongAnswers'] as int,
      isDone: json['isDone'] as bool,
    );
  }

  SkillTestState copyWith({
    List<Translation>? translations,
    int? correctAnswers,
    int? wrongAnswers,
    bool? isDone,
  }) {
    return SkillTestState(
      translations: translations ?? this.translations,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      isDone: isDone ?? this.isDone,
    );
  }

  Translation? get translation {
    return translations.isNotEmpty ? translations[0] : null;
  }
}
