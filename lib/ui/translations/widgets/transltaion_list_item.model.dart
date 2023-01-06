import 'package:translate_1/domain/models/translation.model.dart';

class TranslationListItem {
  late bool isLoading;
  late Translation? data;
  TranslationListItem({
    required this.isLoading,
    required this.data,
  });
}
