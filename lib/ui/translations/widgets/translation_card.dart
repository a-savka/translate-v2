import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/ui/translations/widgets/colors.dart';

class TranslationCard extends StatefulWidget {
  final Translation translation;
  const TranslationCard({
    required this.translation,
    Key? key,
  }) : super(key: key);

  @override
  State<TranslationCard> createState() => TranslationCardState();
}

class TranslationCardState extends State<TranslationCard> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Text(
            widget.translation.text,
            style: TextStyle(color: AppColors.tileColor.withAlpha(0xB0)),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            widget.translation.translate[0],
            style: TextStyle(color: AppColors.tileColor.withAlpha(0xB0)),
          ),
        ),
      ],
    );
  }
}
