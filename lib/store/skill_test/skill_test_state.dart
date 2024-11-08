import 'package:translate_1/domain/models/question.model.dart';

enum SkillTestStatus { pending, progress, done }

class SkillTestState {
  final List<Question> questions;
  final int correctAnswers;
  final int wrongAnswers;
  final int questionCount;
  final bool isDone;
  SkillTestState({
    required this.questions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.questionCount,
    required this.isDone,
  });

  factory SkillTestState.initialState() {
    return SkillTestState(
      questions: [],
      correctAnswers: 0,
      wrongAnswers: 0,
      questionCount: 0,
      isDone: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((question) => question.toJson()).toList(),
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'questionCount': questionCount,
      'isDone': isDone,
    };
  }

  factory SkillTestState.fromJson(Map<String, dynamic> json) {
    return SkillTestState(
      questions: (json['questions'] as List<dynamic>)
          .map((data) => Question.fromJson(data))
          .toList(),
      correctAnswers: json['correctAnswers'] as int,
      wrongAnswers: json['wrongAnswers'] as int,
      questionCount: json['questionCount'] as int,
      isDone: json['isDone'] as bool,
    );
  }

  SkillTestState copyWith({
    List<Question>? questions,
    int? correctAnswers,
    int? wrongAnswers,
    int? questionCount,
    bool? isDone,
  }) {
    return SkillTestState(
      questions: questions ?? this.questions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      questionCount: questionCount ?? this.questionCount,
      isDone: isDone ?? this.isDone,
    );
  }

  SkillTestStatus get status {
    if (questions.isEmpty) {
      if (isDone) {
        return SkillTestStatus.done;
      }
      return SkillTestStatus.pending;
    }
    return SkillTestStatus.progress;
  }

  Question? get currentQuestion {
    if (status != SkillTestStatus.progress || questions.isEmpty) {
      return null;
    }
    return questions[0];
  }

  int get currentQuestionNumber {
    if (status != SkillTestStatus.progress) {
      return 0;
    }
    return questionCount - questions.length + 1;
  }
}
