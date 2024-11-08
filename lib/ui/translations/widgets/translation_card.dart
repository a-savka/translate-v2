import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:intl/intl.dart';
import 'package:translate_1/ui/translations/widgets/edit_translation.dart';
import 'package:translate_1/ui/translations/widgets/generic_confirmation.dart';

class TranslationCard extends StatelessWidget {
  final Translation translation;
  final void Function() onTap;
  final void Function() onDelete;
  final void Function(Translation translation) onEdit;
  final bool isOpen;
  const TranslationCard({
    required this.translation,
    required this.onTap,
    required this.isOpen,
    required this.onDelete,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
            child: _cardHeader(context),
          ),
        ),
        SizedBox(
          height: 110,
          child: !isOpen
              ? const SizedBox()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    _cardDataRow(
                      context,
                      'Total tests: ',
                      translation.shownTimes.toString(),
                    ),
                    _cardDataRow(
                      context,
                      'Correct answers: ',
                      translation.correctAnswers.toString(),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Container(
                      height: 0.5,
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(0x30),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            dateFormat.format(DateTime.parse(
                                translation.dateOfLastTranslate)),
                            style: TextStyle(
                              color: _getControlColor(context),
                              fontSize: 12,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16))),
                                isDismissible: false,
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Wrap(
                                    children: [
                                      EditTranslation(
                                          title: 'Edit translation',
                                          translation: translation,
                                          onEdit: (Translation edited) {
                                            Navigator.pop(context);
                                            onEdit(edited);
                                          },
                                          onCancel: () {
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                            color: _getControlColor(context),
                            iconSize: 20,
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16))),
                                isDismissible: false,
                                builder: (BuildContext context) {
                                  return GenericConfirmation(
                                    title: 'Please Confirm',
                                    message: 'Delete this record?',
                                    onConfirm: () {
                                      Navigator.pop(context);
                                      onDelete();
                                    },
                                    onReject: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                            color: _getControlColor(context),
                            iconSize: 20,
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        )
      ],
    );
  }

  Widget _cardHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Text(
            translation.text,
            // style: TextStyle(color: AppColors.tileColor.withAlpha(0xB0)),
            style: TextStyle(
                color: _getColor(context), fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            translation.translate[0],
            style: TextStyle(color: _getColor(context)),
          ),
        ),
      ],
    );
  }

  Widget _cardDataRow(
    BuildContext context,
    String caption,
    String data,
  ) {
    final textStyle = TextStyle(color: _getColor(context), fontSize: 12);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Text(
            caption,
            style: textStyle,
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            data,
            style: textStyle,
          ),
        )
      ],
    );
  }

  Color _getColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  Color _getControlColor(BuildContext context) {
    return _invert(Theme.of(context).colorScheme.secondary);
  }

  Color _toDark(Color source, {double k = 1.3}) {
    return source
        .withBlue(source.blue ~/ k)
        .withGreen(source.green ~/ k)
        .withRed(source.red ~/ k);
  }

  Color _invert(Color source) {
    return source
        .withBlue((source.red + source.green) ~/ 2)
        .withRed((source.blue + source.green) ~/ 2)
        .withGreen((source.red + source.blue) ~/ 2);
  }
}
