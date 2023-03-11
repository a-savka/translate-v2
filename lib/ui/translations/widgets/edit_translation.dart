import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';

class EditTranslation extends StatefulWidget {
  final String title;
  final Translation translation;
  final void Function(Translation translation) onEdit;
  final VoidCallback onCancel;
  const EditTranslation({
    Key? key,
    required this.title,
    required this.translation,
    required this.onEdit,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<EditTranslation> createState() => EditTranslationState();
}

class EditTranslationState extends State<EditTranslation> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller =
        TextEditingController(text: widget.translation.translate.join('\n'));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: const ColoredBox(
                color: Colors.grey,
                child: SizedBox(
                  height: 4,
                  width: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 30, 70, 15),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: controller,
                  maxLines: 4,
                )),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ElevatedButton(
                onPressed:
                    controller.text.split('\n').any((line) => line.isNotEmpty)
                        ? () {
                            widget.onEdit(
                              widget.translation.copyWith(
                                translate: controller.text
                                    .split('\n')
                                    .where((line) => line.isNotEmpty)
                                    .toList(),
                              ),
                            );
                          }
                        : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Save',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Text(
                  'Cancel',
                ),
              ),
            ),
            const SizedBox(
              height: 140,
            ),
          ],
        ),
      ),
    );
  }
}
