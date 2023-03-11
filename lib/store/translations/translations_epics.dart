import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/store/app_state.dart';
import 'package:translate_1/store/translations/translations_actions.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';

Epic<AppState> _loadTranslationsEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<LoadTranslationsAction>()
        .switchMap(_loadTranslations);
  };
}

Stream<dynamic> _loadTranslations(LoadTranslationsAction action) async* {
  try {
    final FileSystemService fileSystem = getIt.get<FileSystemService>();
    final json = await fileSystem.readJsonFile(action.path);
    if (json != null) {
      final Translations translations = Translations.fromJson(json);
      yield LoadTranslationsSuccessAction(translations.data);
    } else {
      yield LoadTranslationsFailAction();
    }
  } catch (_) {
    yield LoadTranslationsFailAction();
  }
}

Epic<AppState> translationsEpics() => combineEpics<AppState>([
      _loadTranslationsEpic(),
    ]);
