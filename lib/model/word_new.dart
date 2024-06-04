import 'package:cloud_firestore/cloud_firestore.dart';

class WordModel {
  final String? id;
  final String word;
  final int box;
  final List<String> translations;
  final String level;
  final String lesson;
  final DateTime updateTime;

  WordModel({
    this.id,
    required this.word,
    this.box = 0,
    required this.translations,
    required this.level,
    required this.lesson,
    required this.updateTime,
  });

  WordModel copyWith({
    String? id,
    String? word,
    int? box,
    List<String>? translations,
    String? level,
    String? lesson,
    DateTime? updateTime,
  }) =>
      WordModel(
        id: id ?? this.id,
        word: word ?? this.word,
        box: box ?? this.box,
        translations: translations ?? this.translations,
        level: level ?? this.level,
        lesson: lesson ?? this.lesson,
        updateTime: updateTime ?? this.updateTime,
      );

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
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

  static List<WordModel> wordList = [
    // GREETINGS AND FAREWELLS
    WordModel(
      word: "Hello",
      translations: ["Hallo", "Hello", "Hola"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Thank you",
      translations: ["Danke", "Thank you", "Gracias"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Please",
      translations: ["Bitte", "Please", "Por favor"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Goodbye",
      translations: ["Tschuss", "Goodbye", "Adios"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Come",
      translations: ["kommen", "Come", "Venir"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    // PERSONAL INFORMATION
    WordModel(
      word: "Gender",
      translations: ["Geschlect", "Gender", "Genero"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Address",
      translations: ["Adresse", "Address", "Direccion"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "House number",
      translations: ["Hausenummer", "House number", "Numero de casa"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Telephone number",
      translations: ["Telefonnumer", "Telephone number", "Numero de telefono"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Mobile phone number",
      translations: ["Handynummer", "Mobile phone number", "Numero de telefono movil"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Telephone number",
      translations: ["Mobilnummer", "Mobile number", "Numero movil"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    // NUMBERS
    WordModel(
      word: "Zero",
      translations: ["Null", "Zero", "Cero"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "One",
      translations: ["Eins", "One", "Uno"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Two",
      translations: ["Zwei", "Two", "Dos"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Three",
      translations: ["Drei", "Three", "Tres"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Four",
      translations: ["Vier", "Four", "Cuatro"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Five",
      translations: ["Fünf", "Five", "Cinco"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    // COUNTRIES
    WordModel(
      word: "Germany",
      translations: ["Deutschland", "Germany", "Alemania"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "France",
      translations: ["Frankreich", "France", "Francia"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Spain",
      translations: ["Spanien", "Spain", "España"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Italy",
      translations: ["Italien", "Italy", "Italia"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "United Kingdom",
      translations: ["Großbritannien", "United Kingdom", "Reino Unido"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Clothing",
      translations: ["Kleidung ", "Clothing", "Ropa"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Clothing",
      translations: ["Hemd ", "Shirt", "Camisa"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Clothing",
      translations: ["Bluse ", "Blouse", "Blusa"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Clothing",
      translations: ["T-Shirt ", "T-shirt", "Camiseta"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Clothing",
      translations: ["Pullover ", "Sweater", "Suéter"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Festival",
      translations: ["Fest", "Festival", "Festival"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Birthday",
      translations: ["Geburtstag", "Birthday", "Cumpleaños"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Christmas",
      translations: ["Weihnachten", "Christmas", "Navidad"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Easter",
      translations: ["Ostern", "Easter", "Pascua"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "New Year's Eve",
      translations: ["Silvester", "New Year's Eve", "Nochevieja"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Gift",
      translations: ["Geschenk", "Gift", "Regalo"],
      level: "A2 ",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "to give",
      translations: ["schenken", "to give", "regalar"],
      level: "A2",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "to receive",
      translations: ["bekommen", "to receive", "recibir"],
      level: "A2",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Surprise",
      translations: ["Überraschung", "Surprise", "Sorpresa"],
      level: "A2",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Birthday present",
      translations: ["Geburtstagsgeschenk", "Birthday present", "Regalo de cumpleaños"],
      level: "A2",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Friend",
      translations: ["Freund", "Friend", "Amigo"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Girlfriend",
      translations: ["Freundin", "Girlfriend", "Amiga"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Acquaintance",
      translations: ["Bekannte", "Acquaintance", "Conocido"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Pal",
      translations: ["Kumpel", "Pal", "Compañero"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Pal",
      translations: ["Kumpeline", "Pal", "Compañera"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Parents",
      translations: ["Eltern", "Parents", "Padres"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Grandparents",
      translations: ["Großeltern", "Grandparents", "Abuelos"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Children",
      translations: ["Kinder", "Children", "Hijos"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Siblings",
      translations: ["Geschwister", "Siblings", "Hermanos"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Son",
      translations: ["Sohn", "Son", "Hijo"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
  ];
}
