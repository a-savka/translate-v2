import 'package:redux_epics/redux_epics.dart';
import 'package:translate_1/store/app_state.dart';
import 'package:translate_1/store/translations/translations_epics.dart';

Epic<AppState> epics() => combineEpics<AppState>(
      [
        translationsEpics(),
      ],
    );
