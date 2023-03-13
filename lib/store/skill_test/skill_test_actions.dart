import 'package:translate_1/domain/models/translation.model.dart';

abstract class SkillTestAction {}

class StartSkillTestAction extends SkillTestAction {
  final List<Translation> translations;
  StartSkillTestAction(this.translations);
}

class SkillTestAnswerAction extends SkillTestAction {
  final bool isCorrect;
  SkillTestAnswerAction(this.isCorrect);
}
