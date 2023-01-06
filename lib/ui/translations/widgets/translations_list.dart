import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/ui/translations/widgets/rounded_button.dart';
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

  @override
  void initState() {
    super.initState();
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
            child: RoundedButton(
              title: 'Hello there',
              onPressed: () {
                _addFakeItem();
              },
            ),
          ),
        ),
      ],
    );
  }

  void _addFakeItem() {
    final TranslationListItem newItem = TranslationListItem(
      isLoading: true,
      data: Translation(
        id: 'FAKEONE',
        category: 'test',
        text: 'Fake item',
        translate: ['fake'],
        correctAnswers: 0,
        shownTimes: 0,
        translateRequestsCount: 0,
        description: '',
        dateAdded: DateTime.now().toIso8601String(),
        dateOfLastTranslate: DateTime.now().toIso8601String(),
      ),
    );
    listKey.currentState!.insertItem(
      0,
      duration: const Duration(milliseconds: 2000),
    );
    setState(() {
      translations = [newItem, ...translations];
    });
    Future.delayed(const Duration(milliseconds: 1500)).then((_) {
      setState(() {
        newItem.isLoading = false;
      });
    });
  }
}
