class DataModel {
  final List<LessonModel> lessons;
  final List<LevelModel> levels;
  final List<WordModel> words;

  DataModel({
    required this.lessons,
    required this.levels,
    required this.words,
  });

  DataModel copyWith({
    List<LessonModel>? lessons,
    List<LevelModel>? levels,
    List<WordModel>? words,
  }) =>
      DataModel(
        lessons: lessons ?? this.lessons,
        levels: levels ?? this.levels,
        words: words ?? this.words,
      );

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    lessons: List<LessonModel>.from(json["lessons"].map((x) => LessonModel.fromJson(x))),
    levels: List<LevelModel>.from(json["levels"].map((x) => LevelModel.fromJson(x))),
    words: List<WordModel>.from(json["words"].map((x) => WordModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
    "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
    "words": List<dynamic>.from(words.map((x) => x.toJson())),
  };
}

class LessonModel {
  final String description;
  final int id;
  final String name;
  final bool unlocked;

  LessonModel({
    required this.description,
    required this.id,
    required this.name,
    required this.unlocked,
  });

  LessonModel copyWith({
    String? description,
    int? id,
    String? name,
    bool? unlocked,
  }) =>
      LessonModel(
        description: description ?? this.description,
        id: id ?? this.id,
        name: name ?? this.name,
        unlocked: unlocked ?? this.unlocked,
      );

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
    description: json["description"],
    id: json["id"],
    name: json["name"],
    unlocked: json["unlocked"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "id": id,
    "name": name,
    "unlocked": unlocked,
  };
}

class LevelModel {
  final String name;
  final bool unlocked;

  LevelModel({
    required this.name,
    required this.unlocked,
  });

  LevelModel copyWith({
    String? name,
    bool? unlocked,
  }) =>
      LevelModel(
        name: name ?? this.name,
        unlocked: unlocked ?? this.unlocked,
      );

  factory LevelModel.fromJson(Map<String, dynamic> json) => LevelModel(
    name: json["name"],
    unlocked: json["unlocked"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "unlocked": unlocked,
  };
}

class WordModel {
  final String category;
  final String lesson;
  final String level;
  final List<Translation> translations;

  WordModel({
    required this.category,
    required this.lesson,
    required this.level,
    required this.translations,
  });

  WordModel copyWith({
    String? category,
    String? lesson,
    String? level,
    List<Translation>? translations,
  }) =>
      WordModel(
        category: category ?? this.category,
        lesson: lesson ?? this.lesson,
        level: level ?? this.level,
        translations: translations ?? this.translations,
      );

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
    category: json["category"],
    lesson: json["lesson"],
    level: json["level"],
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "lesson": lesson,
    "level": level,
    "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
  };
}

class Translation {
  final int box;
  final String de;
  final String translationDefault;
  final String en;
  final String es;
  final String ph;

  Translation({
    required this.box,
    required this.de,
    required this.translationDefault,
    required this.en,
    required this.es,
    required this.ph,
  });

  Translation copyWith({
    int? box,
    String? de,
    String? translationDefault,
    String? en,
    String? es,
    String? ph,
  }) =>
      Translation(
        box: box ?? this.box,
        de: de ?? this.de,
        translationDefault: translationDefault ?? this.translationDefault,
        en: en ?? this.en,
        es: es ?? this.es,
        ph: ph ?? this.ph,
      );

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    box: json["box"],
    de: json["de"],
    translationDefault: json["default"],
    en: json["en"],
    es: json["es"],
    ph: json["ph"],
  );

  Map<String, dynamic> toJson() => {
    "box": box,
    "de": de,
    "default": translationDefault,
    "en": en,
    "es": es,
    "ph": ph,
  };
}
