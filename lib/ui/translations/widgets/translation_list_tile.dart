import 'package:flutter/material.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'package:translate_1/ui/translations/widgets/colors.dart';
import 'package:translate_1/ui/translations/widgets/translation_card.dart';
import 'package:translate_1/ui/translations/widgets/transltaion_list_item.model.dart';

class TranslationListTile extends StatefulWidget {
  final TranslationListItem item;
  final Animation<double> animation;
  final void Function() onDelete;
  final void Function(Translation translation) onEdit;
  const TranslationListTile({
    Key? key,
    required this.item,
    required this.animation,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<TranslationListTile> createState() => TranslationListTileState();
}

class TranslationListTileState extends State<TranslationListTile>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: widget.animation,
      ),
      child: ScaleTransition(
        scale: CurvedAnimation(
          curve: Curves.fastOutSlowIn,
          parent: widget.animation,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isOpen ? 150 : 50,
          margin: const EdgeInsets.fromLTRB(5, 1, 5, 1),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // border: Border(
            //   top: BorderSide(
            //       width: 1, color: AppColors.tileColor.withAlpha(0x30)),
            // ),
            color: Theme.of(context).colorScheme.tertiary.withAlpha(0x50),
          ),
          child: widget.item.isLoading
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : widget.item.data == null
                  ? Text(
                      'No data',
                      style:
                          TextStyle(color: AppColors.tileColor.withAlpha(0xB0)),
                    )
                  : OverflowBox(
                      minHeight: 0,
                      maxHeight: double.infinity,
                      alignment: Alignment.topLeft,
                      child: TranslationCard(
                        translation: widget.item.data!,
                        onTap: () {
                          setState(() {
                            _isOpen = !_isOpen;
                          });
                        },
                        onDelete: widget.onDelete,
                        onEdit: widget.onEdit,
                        isOpen: _isOpen,
                      )),
        ),
      ),
    );
  }
}
