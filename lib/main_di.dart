import 'package:get_it/get_it.dart';
import 'package:translate_1/domain/providers/translations.provider.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';
import 'package:translate_1/domain/services/google_translate.service.dart';
import 'package:translate_1/domain/services/libre_translate.service.dart';
import 'package:translate_1/domain/services/scaffold_service.dart';
import 'package:translate_1/domain/services/skill_testing/skill_test_service.dart';
import 'package:translate_1/domain/services/yandex_translate.service.dart';
import 'package:translate_1/store/app_store.dart';
import 'package:translate_1/domain/services/cuid_service.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<ScaffoldService>(
    ScaffoldService(),
  );

  getIt.registerSingleton<CuidService>(
    CuidService(),
  );

  getIt.registerSingleton<SkillTestService>(
    SkillTestService(),
  );

  getIt.registerSingleton<LibreTranslateService>(
    LibreTranslateService(),
  );

  getIt.registerSingleton<YandexTranslateService>(
    YandexTranslateService(),
  );

  getIt.registerSingleton<GoogleTranslateService>(
    GoogleTranslateService(),
  );

  getIt.registerSingleton<FileSystemService>(
    FileSystemService(),
  );

  getIt.registerSingleton<TranslationsProvider>(
    TranslationsProvider(
      filesystem: getIt.get<FileSystemService>(),
    ),
  );

  getIt.registerSingletonAsync<AppStore>(
    AppStore.init,
    signalsReady: false,
  );
}
