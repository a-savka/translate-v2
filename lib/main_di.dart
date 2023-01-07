import 'package:get_it/get_it.dart';
import 'package:translate_1/domain/providers/translations.provider.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';
import 'package:translate_1/domain/services/libre_translate.service.dart';
import 'package:translate_1/domain/services/yandex_translate.service.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<LibreTranslateService>(
    LibreTranslateService(),
  );

  getIt.registerSingleton<YandexTranslateService>(
    YandexTranslateService(),
  );

  getIt.registerSingleton<FilesystemService>(
    FilesystemService(),
  );

  getIt.registerSingleton<TranslationsProvider>(
    TranslationsProvider(
      filesystem: getIt.get<FilesystemService>(),
    ),
  );
}
