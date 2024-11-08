class Translation {
  final String id;
  final String text;
  final List<String> translate;
  final String? description;
  final String dateAdded;
  final String dateOfLastTranslate;
  final int translateRequestsCount;
  final String category;
  final int shownTimes;
  final int correctAnswers;

  Translation({
    required this.id,
    required this.text,
    required this.translate,
    this.description,
    required this.dateAdded,
    required this.dateOfLastTranslate,
    required this.translateRequestsCount,
    required this.category,
    required this.shownTimes,
    required this.correctAnswers,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      id: json['id'] as String,
      text: json['text'] as String,
      description: json['description'] as String?,
      translate:
          (json['translate'] as List).map((item) => item as String).toList(),
      dateAdded: json['dateAdded'] as String,
      dateOfLastTranslate: json['dateOfLastTranslate'] as String,
      translateRequestsCount: json['translateRequestsCount'] as int,
      category: json['category'] as String,
      shownTimes: json['shownTimes'] as int,
      correctAnswers: json['correctAnswers'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'description': description,
      'translate': translate,
      'dateAdded': dateAdded,
      'dateOfLastTranslate': dateOfLastTranslate,
      'translateRequestsCount': translateRequestsCount,
      'category': category,
      'shownTimes': shownTimes,
      'correctAnswers': correctAnswers,
    };
  }

  Translation copyWith({
    String? id,
    String? text,
    List<String>? translate,
    String? description,
    String? dateAdded,
    String? dateOfLastTranslate,
    int? translateRequestsCount,
    String? category,
    int? shownTimes,
    int? correctAnswers,
  }) {
    return Translation(
      id: id ?? this.id,
      text: text ?? this.text,
      translate: translate ?? this.translate,
      dateAdded: dateAdded ?? this.dateAdded,
      dateOfLastTranslate: dateOfLastTranslate ?? this.dateOfLastTranslate,
      translateRequestsCount:
          translateRequestsCount ?? this.translateRequestsCount,
      category: category ?? this.category,
      shownTimes: shownTimes ?? this.shownTimes,
      correctAnswers: correctAnswers ?? this.correctAnswers,
    );
  }

  double getKnowledgeIndex() {
    if (correctAnswers == 0) {
      return 0;
    }
    return shownTimes / correctAnswers;
  }
}

class Translations {
  final List<Translation> data;
  Translations({
    required this.data,
  });

  factory Translations.fromJson(Map<String, dynamic> json) {
    return Translations(
        data: (json['data'] as List<dynamic>)
            .map((e) => Translation.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}
