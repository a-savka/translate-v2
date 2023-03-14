import 'package:translate_1/domain/models/translation.model.dart';

class QuizOption {
  final String text;
  final bool isValid;

  QuizOption({
    required this.text,
    required this.isValid,
  });

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      text: json['text'] as String,
      isValid: json['isValid'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isValid': isValid,
    };
  }

  QuizOption copyWith({
    String? text,
    bool? isValid,
  }) {
    return QuizOption(
      text: text ?? this.text,
      isValid: isValid ?? this.isValid,
    );
  }
}

class Question {
  final Translation translation;
  final String text;
  final List<QuizOption> options;

  Question({
    required this.translation,
    required this.text,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      translation:
          Translation.fromJson(json['translation'] as Map<String, dynamic>),
      text: json['text'] as String,
      options: (json['options'] as List<dynamic>)
          .map((data) => QuizOption.fromJson(data))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translation': translation.toJson(),
      'text': text,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }

  Question copyWith({
    Translation? translation,
    String? text,
    List<QuizOption>? options,
  }) {
    return Question(
      translation: translation ?? this.translation,
      text: text ?? this.text,
      options: options ?? this.options,
    );
  }
}
