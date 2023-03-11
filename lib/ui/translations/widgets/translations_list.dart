import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/google_translate.service.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/ui/translations/widgets/edit_translation.dart';
import 'package:translate_1/ui/translations/widgets/generic_confirmation.dart';
import 'package:translate_1/ui/translations/widgets/translation_input_field.dart';
import 'package:translate_1/ui/translations/widgets/translation_list_tile.dart';
import 'package:translate_1/ui/translations/widgets/transltaion_list_item.model.dart';

class TranslationsList extends StatefulWidget {
  final List<Translation> translations;
  final void Function(Translation translation) onAdd;
  final void Function(Translation translation) onUpdate;
  final void Function(Translation translation) onDelete;
  const TranslationsList({
    required this.translations,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<TranslationsList> createState() {
    return TranslationsListState();
  }
}

class TranslationsListState extends State<TranslationsList> {
  late List<TranslationListItem> translations;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  bool isInProgress = false;

  @override
  void initState() {
    super.initState();
    isInProgress = false;
    translations = widget.translations
        .map(
          (it) => TranslationListItem(
            isLoading: false,
            data: it,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedList(
          key: listKey,
          initialItemCount: translations.length,
          itemBuilder: (BuildContext context, int index, Animation animation) {
            return TranslationListTile(
              key: Key(translations[index].data?.text ?? 'inprogress'),
              item: translations[index],
              animation: animation as Animation<double>,
              onDelete: () {
                if (translations[index].data != null) {
                  widget.onDelete(translations[index].data!);
                }
                _removeItem(translations[index]);
              },
              onEdit: (Translation translation) {
                setState(() {
                  translations[index].data = translation;
                });
                widget.onUpdate(translation);
              },
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
            child: TranslationInput(
              disabled: isInProgress,
              onTranslate: (String text) {
                final translated = _getTranslated(text);
                if (translated != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Already translated'),
                      backgroundColor: Color(0x600000FF),
                      duration: Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                    ),
                  );
                  _updateTranslated(translated);
                } else {
                  _translate(text, context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  TranslationListItem? _getTranslated(String text) {
    int index = translations.indexWhere(
      (item) => item.data?.text.toUpperCase() == text.toUpperCase(),
    );
    if (index >= 0) {
      return translations[index];
    }
    return null;
  }

  void _translate(String text, BuildContext context) async {
    final TranslationListItem newItem = TranslationListItem(
      isLoading: true,
      data: null,
    );
    listKey.currentState!.insertItem(
      0,
      duration: const Duration(milliseconds: 1000),
    );
    setState(() {
      translations = [newItem, ...translations];
    });

    Translation translation = Translation(
      id: 'newniceid',
      category: 'test',
      text: text,
      translate: [],
      correctAnswers: 0,
      shownTimes: 0,
      translateRequestsCount: 1,
      description: '',
      dateAdded: DateTime.now().toUtc().toIso8601String(),
      dateOfLastTranslate: DateTime.now().toUtc().toIso8601String(),
    );

    GoogleTranslateService translator = getIt.get<GoogleTranslateService>();

    setState(() {
      isInProgress = true;
    });
    List<String> result;
    try {
      result = await translator.translate(text);
    } catch (_) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        isDismissible: false,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return GenericConfirmation(
            title: 'Translate Failed',
            message: 'Do you whant to add translation manually?',
            onConfirm: () {
              Navigator.pop(context);
              _addManualTranslation(
                translation,
                context,
                newItem,
              );
            },
            onReject: () {
              Navigator.pop(context);
              listKey.currentState!.removeItem(
                0,
                (context, animation) => TranslationListTile(
                  item: newItem,
                  animation: animation,
                  onDelete: () {},
                  onEdit: (_) {},
                ),
              );
              setState(() {
                translations.removeAt(0);
              });
            },
          );
        },
      );
      return;
    } finally {
      setState(() {
        isInProgress = false;
      });
    }

    translation = translation.copyWith(translate: result);

    setState(() {
      newItem.isLoading = false;
      newItem.data = translation;
    });

    widget.onAdd(translation);
  }

  void _removeItem(TranslationListItem item) {
    int index = translations.indexOf(item);
    if (index != -1) {
      listKey.currentState!.removeItem(
        index,
        (context, animation) => TranslationListTile(
          item: item,
          animation: animation,
          onDelete: () {},
          onEdit: (_) {},
        ),
      );
    }
    setState(() {
      translations.removeAt(index);
    });
  }

  void _addManualTranslation(
    Translation translation,
    BuildContext context,
    TranslationListItem newItem,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      isDismissible: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            EditTranslation(
                title: 'Add translation',
                translation: translation,
                onEdit: (Translation edited) {
                  setState(() {
                    newItem.isLoading = false;
                    newItem.data = edited;
                  });

                  widget.onAdd(edited);

                  Navigator.pop(context);
                },
                onCancel: () {
                  Navigator.pop(context);
                  listKey.currentState!.removeItem(
                    0,
                    (context, animation) => TranslationListTile(
                      item: newItem,
                      animation: animation,
                      onDelete: () {},
                      onEdit: (_) {},
                    ),
                  );
                  setState(() {
                    translations.removeAt(0);
                  });
                }),
          ],
        );
      },
    );
  }

  void _updateTranslated(TranslationListItem item) {
    if (item.data != null) {
      int index = translations.indexOf(item);

      listKey.currentState!.removeItem(
        index,
        (context, animation) => TranslationListTile(
          item: item,
          animation: animation,
          onDelete: () {},
          onEdit: (_) {},
        ),
      );

      item.data = item.data!.copyWith(
        dateOfLastTranslate: DateTime.now().toUtc().toIso8601String(),
        translateRequestsCount: item.data!.translateRequestsCount + 1,
      );

      listKey.currentState!.insertItem(
        0,
        duration: const Duration(milliseconds: 1000),
      );

      setState(() {
        translations.removeAt(index);
        translations = [item, ...translations];
      });

      widget.onUpdate(item.data!);
    }
  }
}
