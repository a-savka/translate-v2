import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/filesystem.service.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/store/translations/translations_actions.dart';
import 'package:translate_1/store/translations/translations_state.dart';
import 'package:translate_1/ui/translations/widgets/translations_list.dart';
import 'package:translate_1/store/app_state.dart';

class TranslationsWidget extends StatelessWidget {
  const TranslationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store: store),
      builder: (context, viewModel) {
        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!viewModel.isLoaded) {
          return Center(
            child: MaterialButton(
              onPressed: () {
                viewModel.onLoad();
              },
              color: Colors.green,
              child: const Text(
                'Load Translations',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final List<Translation>? translations = viewModel.translations;
        if (translations == null || translations.isEmpty) {
          return const Center(
            child: Text('No translations available'),
          );
        }

        return TranslationsList(
          translations: translations,
          onAdd: (translation) {
            viewModel.onAdd(translation);
          },
          onUpdate: (translation) {
            viewModel.onUpdate(translation);
          },
          onDelete: (translation) {
            viewModel.onDelete(translation);
          },
        );
      },
    );
  }
}

class _ViewModel {
  final bool isLoading;
  final bool isLoaded;
  final List<Translation>? translations;

  final void Function() onLoad;
  final void Function(Translation translation) onAdd;
  final void Function(Translation translation) onUpdate;
  final void Function(Translation translation) onDelete;

  _ViewModel({
    required this.isLoading,
    required this.isLoaded,
    required this.translations,
    required this.onLoad,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
  });

  factory _ViewModel.fromStore({required Store<AppState> store}) {
    final TranslationsState state = store.state.translationsState;
    return _ViewModel(
      isLoading: state.isLoading,
      isLoaded: state.hasTranslations(),
      translations: state.translations,
      onLoad: () async {
        final FileSystemService fileSystem = getIt.get<FileSystemService>();
        final path = await fileSystem.pickFilePath();
        if (path != null) {
          store.dispatch(LoadTranslationsAction(path));
        }
      },
      onAdd: (translation) {
        store.dispatch(AddTranslationAction(translation));
      },
      onUpdate: (translation) {
        store.dispatch(EditTranslationAction(translation));
      },
      onDelete: (translation) {
        store.dispatch(DeleteTranslationAction(translation.text));
      },
    );
  }
}
