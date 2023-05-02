import 'package:redux/redux.dart';
import 'package:translate_1/store/translations/translations_actions.dart';
import 'package:translate_1/store/translations/translations_state.dart';

final translationsReducer = combineReducers<TranslationsState>([
  TypedReducer<TranslationsState, SetTranslationsAction>(_onSetTranslations),
  TypedReducer<TranslationsState, AddTranslationAction>(_onAddTranslation),
  TypedReducer<TranslationsState, EditTranslationAction>(_onEditTranslation),
  TypedReducer<TranslationsState, LoadTranslationsAction>(_onLoad),
  TypedReducer<TranslationsState, LoadTranslationsSuccessAction>(
      _onLoadSuccess),
  TypedReducer<TranslationsState, LoadTranslationsFailAction>(_onLoadFail),
  TypedReducer<TranslationsState, DeleteTranslationAction>(
      _onDeleteTranslation),
  TypedReducer<TranslationsState, TranslationAnswerAction>(
      _onTranslationAnswer),
]);

TranslationsState _onSetTranslations(
  TranslationsState state,
  SetTranslationsAction action,
) {
  return state.copyWith(translations: [...action.translations]);
}

TranslationsState _onAddTranslation(
  TranslationsState state,
  AddTranslationAction action,
) {
  if (state.translations == null) {
    return state.copyWith(translations: [action.translation.copyWith()]);
  }
  if (state.translations!
      .any((element) => element.text == action.translation.text)) {
    return state;
  }
  return state.copyWith(
    translations: [...state.translations!, action.translation.copyWith()],
  );
}

TranslationsState _onEditTranslation(
  TranslationsState state,
  EditTranslationAction action,
) {
  if (state.translations == null) {
    return state;
  }
  return state.copyWith(
    translations: state.translations!.map(
      (e) {
        if (e.text == action.translation.text) {
          return action.translation.copyWith();
        }
        return e;
      },
    ).toList(),
  );
}

TranslationsState _onTranslationAnswer(
  TranslationsState state,
  TranslationAnswerAction action,
) {
  return state.copyWith(
    translations: state.translations!.map(
      (e) {
        if (e.text == action.text) {
          return e.copyWith(
            shownTimes: e.shownTimes + 1,
            correctAnswers: e.correctAnswers + (action.isValid ? 1 : 0),
          );
        }
        return e;
      },
    ).toList(),
  );
}

TranslationsState _onDeleteTranslation(
  TranslationsState state,
  DeleteTranslationAction action,
) {
  return state.copyWith(
    translations: state.translations
        ?.where((element) => element.text != action.text)
        .toList(),
  );
}

TranslationsState _onLoad(
  TranslationsState state,
  LoadTranslationsAction action,
) {
  return state.copyWith(isLoading: true);
}

TranslationsState _onLoadSuccess(
  TranslationsState state,
  LoadTranslationsSuccessAction action,
) {
  return state.copyWith(
    isLoading: false,
    translations: [...action.translations],
  );
}

TranslationsState _onLoadFail(
  TranslationsState state,
  LoadTranslationsFailAction action,
) {
  return state.copyWith(isLoading: false);
}
