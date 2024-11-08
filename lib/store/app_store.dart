import 'dart:typed_data';

import 'package:localstorage/localstorage.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:translate_1/store/app_epics.dart';
import 'package:translate_1/store/app_reducer.dart';
import 'package:translate_1/store/app_state.dart';

class AppStore {
  final Store<AppState> store;

  AppStore({
    required this.store,
  });

  static Future<AppStore> init() async {
    final LocalStorage storage = LocalStorage('tarnslations_store');
    await storage.ready;

    final persistor = Persistor<AppState>(
      storage: AppStorage(storage),
      serializer: JsonSerializer<AppState>((json) => AppState.fromJson(json)),
      throttleDuration: const Duration(seconds: 2),
    );

    AppState? initialState;
    try {
      initialState = await persistor.load();
    } catch (_) {}

    return AppStore(
      store: Store<AppState>(
        reducer,
        middleware: [
          EpicMiddleware<AppState>(epics()),
          persistor.createMiddleware(),
        ],
        initialState: initialState ?? AppState.initialState(),
      ),
    );
  }
}

class AppStorage implements StorageEngine {
  final String key = 'app';
  final LocalStorage storage;

  AppStorage(this.storage);

  @override
  Future<Uint8List> load() =>
      Future.value(stringToUint8List(storage.getItem(key)));

  @override
  Future<void> save(Uint8List? data) async {
    storage.setItem(key, uint8ListToString(data));
  }
}
