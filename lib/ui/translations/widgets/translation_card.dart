import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/ui/translations/widgets/colors.dart';

class TranslationCard extends StatelessWidget {
  final Translation translation;
  final void Function() onTap;
  final bool isOpen;
  const TranslationCard({
    required this.translation,
    required this.onTap,
    required this.isOpen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
            child: _cardHeader(context),
          ),
        ),
        const SizedBox(
          height: 100,
          child: Center(
            child: Text('This is sample content'),
          ),
        ),
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
            style: TextStyle(color: AppColors.tileColor.withAlpha(0xB0)),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            translation.translate[0],
            style: TextStyle(color: AppColors.tileColor.withAlpha(0xB0)),
          ),
        ),
      ],
    );
  }
}
