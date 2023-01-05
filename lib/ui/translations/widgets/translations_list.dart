import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:translate_1/domain/models/translation.model.dart';

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
  late List<Translation> translations;

  @override
  void initState() {
    super.initState();
    translations = List.from(widget.translations);
  }

  @override
  Widget build(BuildContext context) {
    const Color tileColor = Color(0xFF3399FF);

    return Stack(
      children: [
        AnimatedList(
          initialItemCount: translations.length,
          itemBuilder: (BuildContext context, int index, Animation animation) {
            return Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: tileColor.withAlpha(0x30)),
                ),
                color: tileColor.withAlpha(0x10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  translations[index].text,
                  style: TextStyle(color: tileColor.withAlpha(0xB0)),
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFDBDBDB)),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green,
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                child: const Text(
                  'Hello',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
