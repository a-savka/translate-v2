import 'package:flutter/widgets.dart';
import 'package:translate_1/ui/translations/widgets/transltaion_list_item.model.dart';

class TranslationListTile extends StatelessWidget {
  final TranslationListItem item;
  final Animation<double> animation;
  const TranslationListTile({
    Key? key,
    required this.item,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color tileColor = Color(0xFF3399FF);
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.5, 0),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
        curve: Curves.elasticOut,
        parent: animation,
      )),
      child: Container(
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
            item.data?.text ?? 'No data',
            style: TextStyle(color: tileColor.withAlpha(0xB0)),
          ),
        ),
      ),
    );
  }
}
