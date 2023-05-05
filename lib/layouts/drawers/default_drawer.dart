import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';
import 'package:translate_1/keys.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/main_navigation.dart';
import 'package:translate_1/store/app_state.dart';
import 'package:translate_1/ui/generic/widgets/generic_confirmation.dart';
import 'package:translate_1/ui/generic/widgets/generic_prompt.dart';

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
                        onTap: () async {
                          final FileSystemService fileSystem =
                              getIt.get<FileSystemService>();
                          String? path = await fileSystem.pickDirectoryPath();
                          if (path != null) {
                            String? fileName = await _requestFileName();
                            if (fileName != null) {
                              path = '$path/$fileName.json';
                              final fileExists = await File(path).exists();
                              final operationConfirmed =
                                  await _confirmFileOperation(fileExists);
                              if (operationConfirmed &&
                                  viewModel.translations != null) {
                                Translations translations =
                                    Translations(data: viewModel.translations!);
                                await fileSystem.writeJsonFile(
                                    path, translations.toJson());
                              }
                              if (mainScaffoldKey.currentState != null &&
                                  mainScaffoldKey.currentState!.isDrawerOpen) {
                                mainScaffoldKey.currentState!.closeDrawer();
                              }
                            }
                          }
                        })
                    : const SizedBox(),
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

  Future<bool> _confirmFileOperation(bool fileExists) async {
    if (!fileExists) {
      return true;
    }

    if (mounted) {
      bool result = false;
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        builder: (context) {
          return GenericConfirmation(
            title: 'File already exists',
            message: 'Overwrite the file?',
            onConfirm: () {
              result = true;
              Navigator.of(context).pop();
            },
            onReject: () {
              result = false;
              Navigator.of(context).pop();
            },
          );
        },
      );
      return result;
    } else {
      return false;
    }
  }

  Future<String?> _requestFileName() async {
    String? result;
    if (mounted) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
            child: GenericPrompt(
              title: 'Specify file name',
              initialValue: 'translations',
              onConfirm: (String? value) {
                result = value;
                Navigator.of(context).pop();
              },
              onReject: () {
                result = null;
                Navigator.of(context).pop();
              },
            ),
          );
        },
      );
      return result;
    } else {
      return null;
    }
  }
}

class _ViewModel {
  final bool hasTranslations;
  final List<Translation>? translations;

  _ViewModel({
    required this.hasTranslations,
    required this.translations,
  });

  factory _ViewModel.fromStore({required Store<AppState> store}) {
    return _ViewModel(
      hasTranslations: store.state.translationsState.hasTranslations(),
      translations: store.state.translationsState.translations,
    );
  }
}
