import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WordModel extends Equatable {
  final String? id;
  final String word;
  final int box;
  final List<String> translations;
  final String level;
  final String lesson;
  final DateTime updateTime;
  final DateTime? lockedTime;

  const WordModel({
    this.id,
    required this.word,
    this.box = 0,
    required this.translations,
    required this.level,
    required this.lesson,
    required this.updateTime,
    this.lockedTime,
  });

  WordModel copyWith({
    String? id,
    String? word,
    int? box,
    List<String>? translations,
    String? level,
    String? lesson,
    DateTime? updateTime,
    DateTime? lockedTime,
  }) =>
      WordModel(
        id: id ?? this.id,
        word: word ?? this.word,
        box: box ?? this.box,
        translations: translations ?? this.translations,
        level: level ?? this.level,
        lesson: lesson ?? this.lesson,
        updateTime: updateTime ?? this.updateTime,
        lockedTime: lockedTime ?? this.lockedTime,
      );

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        id: json["id"],
        word: json["word"],
        box: json["box"],
        translations: List<String>.from(json["translations"].map((x) => x)),
        level: json["level"],
        lesson: json["lesson"],
        updateTime: (json["updateTime"] as Timestamp).toDate(),
        lockedTime: (json["lockedTime"] as Timestamp?)?.toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "word": word,
        "box": box,
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "level": level,
        "lesson": lesson,
        "updateTime": Timestamp.fromDate(updateTime),
        "lockedTime":
            lockedTime == null ? null : Timestamp.fromDate(lockedTime!),
      };

  Duration? getLockedDuration(DateTime now) {
    if (lockedTime == null) return null;

    return now.difference(lockedTime!);
  }

  @override
  List<Object?> get props => [
        id,
        word,
        box,
        translations,
        level,
        lesson,
        updateTime,
        lockedTime,
      ];

  static List<WordModel> wordList = [
    // GREETINGS AND FAREWELLS
    WordModel(
      word: "Hello",
      translations: const ["Hallo", "Hello", "Hola"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Thank you",
      translations: const ["Danke", "Thank you", "Gracias"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Please",
      translations: const ["Bitte", "Please", "Por favor"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Goodbye",
      translations: const ["Tschuss", "Goodbye", "Adios"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Come",
      translations: const ["kommen", "Come", "Venir"],
      level: "A1",
      lesson: "Greetings and Farewells",
      updateTime: DateTime.now(),
    ),
    // PERSONAL INFORMATION
    WordModel(
      word: "Gender",
      translations: const ["Geschlect", "Gender", "Genero"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Address",
      translations: const ["Adresse", "Address", "Direccion"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "House number",
      translations: const ["Hausenummer", "House number", "Numero de casa"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Telephone number",
      translations: const [
        "Telefonnumer",
        "Telephone number",
        "Numero de telefono"
      ],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Mobile phone number",
      translations: const [
        "Handynummer",
        "Mobile phone number",
        "Numero de telefono movil"
      ],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Telephone number",
      translations: const ["Mobilnummer", "Mobile number", "Numero movil"],
      level: "A1",
      lesson: "Personal Information",
      updateTime: DateTime.now(),
    ),
    // NUMBERS
    WordModel(
      word: "Zero",
      translations: const ["Null", "Zero", "Cero"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "One",
      translations: const ["Eins", "One", "Uno"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Two",
      translations: const ["Zwei", "Two", "Dos"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Three",
      translations: const ["Drei", "Three", "Tres"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Four",
      translations: const ["Vier", "Four", "Cuatro"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Five",
      translations: const ["Fünf", "Five", "Cinco"],
      level: "A1",
      lesson: "Numbers",
      updateTime: DateTime.now(),
    ),
    // COUNTRIES
    WordModel(
      word: "Germany",
      translations: const ["Deutschland", "Germany", "Alemania"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "France",
      translations: const ["Frankreich", "France", "Francia"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Spain",
      translations: const ["Spanien", "Spain", "España"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Italy",
      translations: const ["Italien", "Italy", "Italia"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "United Kingdom",
      translations: const ["Großbritannien", "United Kingdom", "Reino Unido"],
      level: "A1",
      lesson: "Countries",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Clothing",
      translations: const ["Kleidung ", "Clothing", "Ropa"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Clothing",
      translations: const ["Hemd ", "Shirt", "Camisa"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Clothing",
      translations: const ["Bluse ", "Blouse", "Blusa"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Clothing",
      translations: const ["T-Shirt ", "T-shirt", "Camiseta"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Clothing",
      translations: const ["Pullover ", "Sweater", "Suéter"],
      level: "A2",
      lesson: "Clothing",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Festival",
      translations: const ["Fest", "Festival", "Festival"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Birthday",
      translations: const ["Geburtstag", "Birthday", "Cumpleaños"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Christmas",
      translations: const ["Weihnachten", "Christmas", "Navidad"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Easter",
      translations: const ["Ostern", "Easter", "Pascua"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "New Year's Eve",
      translations: const ["Silvester", "New Year's Eve", "Nochevieja"],
      level: "A2",
      lesson: "Festival",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Gift",
      translations: const ["Geschenk", "Gift", "Regalo"],
      level: "A2 ",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "to give",
      translations: const ["schenken", "to give", "regalar"],
      level: "A2",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "to receive",
      translations: const ["bekommen", "to receive", "recibir"],
      level: "A2",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Surprise",
      translations: const ["Überraschung", "Surprise", "Sorpresa"],
      level: "A2",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Birthday present",
      translations: const [
        "Geburtstagsgeschenk",
        "Birthday present",
        "Regalo de cumpleaños"
      ],
      level: "A2",
      lesson: "Gift",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Friend",
      translations: const ["Freund", "Friend", "Amigo"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Girlfriend",
      translations: const ["Freundin", "Girlfriend", "Amiga"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Acquaintance",
      translations: const ["Bekannte", "Acquaintance", "Conocido"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Pal",
      translations: const ["Kumpel", "Pal", "Compañero"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Pal",
      translations: const ["Kumpeline", "Pal", "Compañera"],
      level: "A2",
      lesson: "Friend",
      updateTime: DateTime.now(),
    ),

    WordModel(
      word: "Parents",
      translations: const ["Eltern", "Parents", "Padres"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Grandparents",
      translations: const ["Großeltern", "Grandparents", "Abuelos"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Children",
      translations: const ["Kinder", "Children", "Hijos"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Siblings",
      translations: const ["Geschwister", "Siblings", "Hermanos"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
    WordModel(
      word: "Son",
      translations: const ["Sohn", "Son", "Hijo"],
      level: "A2",
      lesson: "Parents",
      updateTime: DateTime.now(),
    ),
  ];
}
