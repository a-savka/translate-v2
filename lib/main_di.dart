import 'package:get_it/get_it.dart';
import 'package:translate_1/domain/providers/translations.provider.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<FilesystemService>(
    FilesystemService(),
  );

  getIt.registerSingleton<TranslationsProvider>(
    TranslationsProvider(
      filesystem: getIt.get<FilesystemService>(),
    ),
  );
}
