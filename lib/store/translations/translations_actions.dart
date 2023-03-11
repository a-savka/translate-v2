import 'package:translate_1/domain/models/translation.model.dart';

abstract class TranslationsAction {}

class SetTranslationsAction extends TranslationsAction {
  final List<Translation> translations;
  SetTranslationsAction(this.translations);
}

class AddTranslationAction extends TranslationsAction {
  final Translation translation;
  AddTranslationAction(this.translation);
}

class EditTranslationAction extends TranslationsAction {
  final Translation translation;
  EditTranslationAction(this.translation);
}

class DeleteTranslationAction extends TranslationsAction {
  final String text;
  DeleteTranslationAction(this.text);
}

class LoadTranslationsAction extends TranslationsAction {
  final String path;
  LoadTranslationsAction(this.path);
}

class LoadTranslationsSuccessAction extends TranslationsAction {
  final List<Translation> translations;
  LoadTranslationsSuccessAction(this.translations);
}

class LoadTranslationsFailAction extends TranslationsAction {}
