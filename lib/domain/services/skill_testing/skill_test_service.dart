import 'package:translate_1/domain/models/question.model.dart';
import 'package:translate_1/domain/models/translation.model.dart';
import 'dart:math';

class SkillTestService {
  List<Question> buildTest({
    required List<Translation> source,
    required int count,
  }) {
    int latestCount = (count * 0.33).toInt();
    int weakCount = (count * 0.33).toInt();
    int goodCount = (count * 0.1).toInt();
    int sum = latestCount + weakCount + goodCount;
    int otherCount = count > sum ? count - sum : 0;

    List<Translation> result;
    if (count > source.length) {
      result = source;
    } else {
      List<Translation> localSource = [...source];

      List<Translation> latest =
          _getLatest(source: localSource, count: latestCount);
      localSource = localSource
          .where((local) => !latest.any((late) => late.text == local.text))
          .toList();

      List<Translation> weak = _getWeak(source: localSource, count: weakCount);
      localSource = localSource
          .where((local) => !weak.any((w) => w.text == local.text))
          .toList();

      List<Translation> good = _getGood(source: localSource, count: goodCount);
      localSource = localSource
          .where((local) => !good.any((g) => g.text == local.text))
          .toList();

      List<Translation> other = _getRandomSlice(
        source: localSource,
        count: otherCount,
        slicePart: 1,
      );

      result = [
        ...latest,
        ...weak,
        ...good,
        ...other,
      ];
    }

    result.shuffle();
    return result
        .map((translation) => toQuestion(translation, source))
        .toList();
  }

  Question toQuestion(
    Translation translation,
    List<Translation> allTranslations, {
    bool reverseTest = false,
  }) {
    List<Translation> localTranslations = [...allTranslations];
    localTranslations.shuffle();
    if (localTranslations.length > 8) {
      localTranslations = localTranslations.sublist(0, 8);
    }
    localTranslations = localTranslations
        .where((element) => element.text != translation.text)
        .toList();
    if (localTranslations.length > 7) {
      localTranslations = localTranslations.sublist(0, 7);
    }

    List<QuizOption> options = localTranslations
        .map((t) => QuizOption(
              text: reverseTest ? t.text : t.translate[0],
              isValid: false,
            ))
        .toList();

    options.add(QuizOption(
      text: reverseTest ? translation.text : translation.translate[0],
      isValid: true,
    ));

    options.shuffle();

    return Question(
      translation: translation,
      text: reverseTest ? translation.translate[0] : translation.text,
      options: options,
    );
  }

  List<Translation> _getLatest({
    required List<Translation> source,
    required int count,
  }) {
    if (count >= source.length) {
      return [...source];
    }
    List<Translation> localSource = [...source];
    localSource.sort((a, b) => DateTime.parse(b.dateOfLastTranslate)
        .compareTo(DateTime.parse(a.dateOfLastTranslate)));

    return _getRandomSlice(
      source: localSource,
      count: count,
      slicePart: 0.3,
    );
  }

  List<Translation> _getWeak({
    required List<Translation> source,
    required int count,
  }) {
    if (count >= source.length) {
      return [...source];
    }
    List<Translation> localSource = [...source];
    localSource
        .sort((a, b) => a.getKnowledgeIndex().compareTo(b.getKnowledgeIndex()));

    return _getRandomSlice(
      source: localSource,
      count: count,
      slicePart: 0.3,
    );
  }

  List<Translation> _getGood({
    required List<Translation> source,
    required int count,
  }) {
    if (count >= source.length) {
      return [...source];
    }
    List<Translation> localSource = [...source];
    localSource
        .sort((a, b) => b.getKnowledgeIndex().compareTo(a.getKnowledgeIndex()));

    return _getRandomSlice(
      source: localSource,
      count: count,
      slicePart: 0.1,
    );
  }

  List<Translation> _getRandomSlice({
    required List<Translation> source,
    required int count,
    required double slicePart,
  }) {
    int candidateCount = (source.length * slicePart).toInt();
    if (candidateCount < count) {
      candidateCount = count;
    }
    List<Translation> localSource = source.sublist(0, candidateCount);

    List<Translation> result = [];
    Random random = Random();

    while (result.length < count) {
      int idx = random.nextInt(localSource.length);
      result.add(localSource[idx]);
      localSource.removeAt(idx);
    }
    return result;
  }
}
