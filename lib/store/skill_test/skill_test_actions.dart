import 'package:translate_1/domain/models/question.model.dart';

abstract class SkillTestAction {}

class StartSkillTestAction extends SkillTestAction {
  final List<Question> questions;
  StartSkillTestAction(this.questions);
}

class SkillTestAnswerAction extends SkillTestAction {
  final bool isCorrect;
  SkillTestAnswerAction(this.isCorrect);
}
