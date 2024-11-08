import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';
import 'package:translate_1/domain/services/scaffold_service.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/main_navigation.dart';
import 'package:translate_1/store/app_state.dart';
import 'package:translate_1/store/translations/translations_actions.dart';

class DefaultDrawer extends StatefulWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  @override
  State<DefaultDrawer> createState() => DefaultDrawerState();
}

class DefaultDrawerState extends State<DefaultDrawer> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store: store),
        builder: (context, viewModel) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Text(
                    'Translator Menu',
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                ),
                ...MainNavigation.sideNav
                    .where((item) =>
                        !item.requireTranslations || viewModel.hasTranslations)
                    .map(
                      (navItem) => ListTile(
                        title: Text(
                          navItem.title,
                          style: _titleTextStyle(context),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(navItem.route);
                        },
                      ),
                    ),
                viewModel.hasTranslations
                    ? ListTile(
                        title: Text(
                          'Save to File',
                          style: _titleTextStyle(context),
                        ),
                        onTap: () => _saveToFile(viewModel.translations),
                      )
                    : const SizedBox(),
                ListTile(
                  title: Text(
                    'Load from File',
                    style: _titleTextStyle(context),
                  ),
                  onTap: () => _loadFromFile(viewModel),
                ),
              ],
            ),
          );
        });
  }

  Color _toDark(Color source) {
    return source
        .withBlue(source.blue ~/ 1.3)
        .withGreen(source.green ~/ 1.3)
        .withRed(source.red ~/ 1.3);
  }

  TextStyle _titleTextStyle(BuildContext context) {
    return TextStyle(color: _toDark(Theme.of(context).colorScheme.tertiary));
  }

  Future<void> _saveToFile(List<Translation>? translationsList) async {
    final FileSystemService fileSystem = getIt.get<FileSystemService>();
    final ScaffoldService scaffoldService = getIt.get<ScaffoldService>();
    String? path = await fileSystem.pickDirectoryPath();
    if (path != null && mounted) {
      String? fileName = await fileSystem.requestFileName(context);
      if (fileName != null) {
        path = '$path/$fileName.json';
        final fileExists = await File(path).exists();
        if (mounted) {
          final operationConfirmed =
              await fileSystem.confirmFileOverwrite(fileExists, context);
          if (operationConfirmed && translationsList != null) {
            Translations translations = Translations(data: translationsList);
            await fileSystem.writeJsonFile(path, translations.toJson());
          }
        }
        scaffoldService.closeDrawer();
      }
    }
  }

  Future<void> _loadFromFile(_ViewModel viewModel) async {
    final FileSystemService fileSystem = getIt.get<FileSystemService>();
    final ScaffoldService scaffoldService = getIt.get<ScaffoldService>();
    bool operationAllowed = true;
    if (viewModel.translations != null) {
      operationAllowed = await fileSystem.confirmContentReload(context);
    }
    if (operationAllowed) {
      await viewModel.onLoad();
    }
    scaffoldService.closeDrawer();
  }
}

class _ViewModel {
  final bool hasTranslations;
  final List<Translation>? translations;
  final Future<void> Function() onLoad;

  _ViewModel({
    required this.hasTranslations,
    required this.translations,
    required this.onLoad,
  });

  factory _ViewModel.fromStore({required Store<AppState> store}) {
    return _ViewModel(
      hasTranslations: store.state.translationsState.hasTranslations(),
      translations: store.state.translationsState.translations,
      onLoad: () async {
        final FileSystemService fileSystem = getIt.get<FileSystemService>();
        final path = await fileSystem.pickFilePath();
        if (path != null) {
          store.dispatch(LoadTranslationsAction(path));
        }
      },
    );
  }
}
