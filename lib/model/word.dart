class WordModel {
  final String word;
  final int box;
  final List<String> translations;

  WordModel({
    required this.word,
    required this.box,
    required this.translations,
  });

  WordModel copyWith({
    String? word,
    int? box,
    List<String>? translations,
  }) =>
      WordModel(
        word: word ?? this.word,
        box: box ?? this.box,
        translations: translations ?? this.translations,
      );

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        word: json["word"],
        box: json["box"],
        translations: List<String>.from(json["translations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "box": box,
        "translations": List<dynamic>.from(translations.map((x) => x)),
      };
}

