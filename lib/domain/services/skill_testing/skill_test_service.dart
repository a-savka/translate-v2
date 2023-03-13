import 'package:translate_1/domain/models/translation.model.dart';
import 'dart:math';

class SkillTestService {
  List<Translation> buildTest({
    required List<Translation> source,
    required int count,
  }) {
    if (count > source.length) {
      return source;
    }

    List<Translation> localSource = [...source];

    List<Translation> latest = _getLatest(source: localSource, count: 10);
    localSource = localSource
        .where((local) => !latest.any((late) => late.text == local.text))
        .toList();

    List<Translation> weak = _getWeak(source: localSource, count: 10);
    localSource = localSource
        .where((local) => !weak.any((w) => w.text == local.text))
        .toList();

    List<Translation> good = _getGood(source: localSource, count: 3);
    localSource = localSource
        .where((local) => !good.any((g) => g.text == local.text))
        .toList();

    List<Translation> other = _getRandomSlice(
      source: localSource,
      count: 7,
      slicePart: 1,
    );

    List<Translation> result = [...latest, ...weak, ...good, ...other];
    result.shuffle();
    return result;
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
    int candidateCount = (source.length * 0.3).toInt();
    if (candidateCount < count) {
      candidateCount = count;
    }
    List<Translation> localSource = source.sublist(0, candidateCount);

    List<Translation> result = [];
    Random random = Random();

    while (result.length < candidateCount) {
      int idx = random.nextInt(localSource.length);
      result.add(localSource[idx]);
      localSource.removeAt(idx);
    }
    return result;
  }
}
