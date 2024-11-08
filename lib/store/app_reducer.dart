import 'package:translate_1/store/app_state.dart';
import 'package:translate_1/store/skill_test/skill_test_reducer.dart';
import 'package:translate_1/store/translations/translations_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    translationsState: translationsReducer(state.translationsState, action),
    skillTestState: skillTestReducer(state.skillTestState, action),
  );
}
