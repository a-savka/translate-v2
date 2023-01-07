import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/domain/services/libre_translate.service.dart';
import 'package:translate_1/domain/services/yandex_translate.service.dart';
import 'package:translate_1/main_di.dart';
import 'package:translate_1/ui/translations/widgets/translation_input_field.dart';
import 'package:translate_1/ui/translations/widgets/translation_list_tile.dart';
import 'package:translate_1/ui/translations/widgets/transltaion_list_item.model.dart';

class TranslationsList extends StatefulWidget {
  final List<Translation> translations;
  const TranslationsList({
    required this.translations,
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
              item: translations[index],
              animation: animation as Animation<double>,
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
                _addFakeItem(text);
              },
            ),
          ),
        ),
      ],
    );
  }

  void _addFakeItem(String text) async {
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

    LibreTranslateService translator = getIt.get<LibreTranslateService>();

    setState(() {
      isInProgress = true;
    });
    List<String> result;
    try {
      result = await translator.translate(text);
    } catch (_) {
      listKey.currentState!.removeItem(
        0,
        (context, animation) => TranslationListTile(
          item: newItem,
          animation: animation,
        ),
      );
      setState(() {
        translations.removeAt(0);
      });
      return;
    } finally {
      setState(() {
        isInProgress = false;
      });
    }

    setState(() {
      newItem.isLoading = false;
      newItem.data = Translation(
        id: 'newniceid',
        category: 'test',
        text: text,
        translate: result,
        correctAnswers: 0,
        shownTimes: 0,
        translateRequestsCount: 0,
        description: '',
        dateAdded: DateTime.now().toIso8601String(),
        dateOfLastTranslate: DateTime.now().toIso8601String(),
      );
    });
  }
}
