import 'package:cloud_firestore/cloud_firestore.dart';

class WordNewModel {
  final String? id;
  final String word;
  final int box;
  final List<String> translations;
  final String level;
  final String lesson;
  final DateTime updateTime;

  WordNewModel({
    this.id,
    required this.word,
    this.box = 0,
    required this.translations,
    required this.level,
    required this.lesson,
    required this.updateTime,
  });

  WordNewModel copyWith({
    String? id,
    String? word,
    int? box,
    List<String>? translations,
    String? level,
    String? lesson,
    DateTime? updateTime,
  }) =>
      WordNewModel(
        id: id ?? this.id,
        word: word ?? this.word,
        box: box ?? this.box,
        translations: translations ?? this.translations,
        level: level ?? this.level,
        lesson: lesson ?? this.lesson,
        updateTime: updateTime ?? this.updateTime,
      );

  factory WordNewModel.fromJson(Map<String, dynamic> json) => WordNewModel(
        id: json["id"],
        word: json["word"],
        box: json["box"],
        translations: List<String>.from(json["translations"].map((x) => x)),
        level: json["level"],
        lesson: json["lesson"],
        updateTime: (json["updateTime"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "word": word,
        "box": box,
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "level": level,
        "lesson": lesson,
        "updateTime": Timestamp.fromDate(updateTime),
      };

  static List<WordNewModel> wordList = [
    // GREETINGS AND FAREWELLS
    WordNewModel(
      word: "Hello",
      translations: ["Hallo", "Hello", "Hola"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Thank you",
      translations: ["Danke", "Thank you", "Gracias"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Please",
      translations: ["Bitte", "Please", "Por favor"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Goodbye",
      translations: ["Tschuss", "Goodbye", "Adios"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Come",
      translations: ["kommen", "Come", "Venir"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    // PERSONAL INFORMATION
    WordNewModel(
      word: "Gender",
      translations: ["Geschlect", "Gender", "Genero"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Address",
      translations: ["Adresse", "Address", "Direccion"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "House number",
      translations: ["Hausenummer", "House number", "Numero de casa"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Telephone number",
      translations: ["Telefonnumer", "Telephone number", "Numero de telefono"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Mobile phone number",
      translations: ["Handynummer", "Mobile phone number", "Numero de telefono movil"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Telephone number",
      translations: ["Mobilnummer", "Mobile number", "Numero movil"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    // NUMBERS
    WordNewModel(
      word: "Zero",
      translations: ["Null", "Zero", "Cero"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "One",
      translations: ["Eins", "One", "Uno"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Two",
      translations: ["Zwei", "Two", "Dos"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Three",
      translations: ["Drei", "Three", "Tres"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Four",
      translations: ["Vier", "Four", "Cuatro"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Five",
      translations: ["Fünf", "Five", "Cinco"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    // COUNTRIES
    WordNewModel(
      word: "Germany",
      translations: ["Deutschland", "Germany", "Alemania"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "France",
      translations: ["Frankreich", "France", "Francia"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Spain",
      translations: ["Spanien", "Spain", "España"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "Italy",
      translations: ["Italien", "Italy", "Italia"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordNewModel(
      word: "United Kingdom",
      translations: ["Großbritannien", "United Kingdom", "Reino Unido"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
  ];
}
