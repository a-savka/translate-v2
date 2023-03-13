import 'package:redux/redux.dart';
import 'package:translate_1/store/skill_test/skill_test_actions.dart';
import 'package:translate_1/store/skill_test/skill_test_state.dart';

final skillTestReducer = combineReducers<SkillTestState>([
  TypedReducer<SkillTestState, StartSkillTestAction>(_startSkillTest),
  TypedReducer<SkillTestState, SkillTestAnswerAction>(_skillTestAnswer),
]);

SkillTestState _startSkillTest(
  SkillTestState state,
  StartSkillTestAction action,
) {
  return state.copyWith(
    translations: action.translations,
    correctAnswers: 0,
    wrongAnswers: 0,
    isDone: false,
  );
}

SkillTestState _skillTestAnswer(
  SkillTestState state,
  SkillTestAnswerAction action,
) {
  return state.copyWith(
    translations: state.translations.sublist(1),
    correctAnswers: state.correctAnswers + (action.isCorrect ? 1 : 0),
    wrongAnswers: state.wrongAnswers + (action.isCorrect ? 0 : 1),
    isDone: state.translations.length == 1,
  );
}
