import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/model/translation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

DateTime? timestampToDate(Timestamp? timestamp) => timestamp?.toDate();

Timestamp? dateToTimestamp(DateTime? date) =>
    date == null ? null : Timestamp.fromDate(date);

@JsonSerializable(explicitToJson: true)
class WordModel extends Equatable {
  final String id;
  final String word;
  final int box;
  final List<Translation> translations;
  final LevelModel level;
  final LessonModel lesson;
  @JsonKey(fromJson: timestampToDate, toJson: dateToTimestamp)
  final DateTime? updateTime;
  @JsonKey(fromJson: timestampToDate, toJson: dateToTimestamp)
  final DateTime? lockedTime;

  const WordModel({
    required this.id,
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
    List<Translation>? translations,
    LevelModel? level,
    LessonModel? lesson,
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

  factory WordModel.fromJson(Map<String, dynamic> json) =>
      _$WordModelFromJson(json);

  Map<String, dynamic> toJson() => _$WordModelToJson(this);

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

  // static List<WordModel> wordList = [
  //   // COUNTRY
  //   WordModel(
  //     id: "word_country",
  //     word: "Country",
  //     translations: const [
  //       Translation(word: "Land", language: "German"),
  //       Translation(word: "Country", language: "English"),
  //       Translation(word: "País", language: "Spanish"),
  //     ],
  //     level: "A1",
  //     lesson: "Countries",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "england",
  //     word: "England",
  //     translations: const [
  //       Translation(word: "England", language: "German"),
  //       Translation(word: "England", language: "English"),
  //       Translation(word: "Inglaterra", language: "Spanish"),
  //     ],
  //     level: "A1",
  //     lesson: "Countries",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "united_kingdom",
  //     word: "United Kingdom",
  //     translations: const [
  //       Translation(word: "Großbritannien", language: "German"),
  //       Translation(word: "United Kingdom", language: "English"),
  //       Translation(word: "Reino Unido", language: "Spanish"),
  //     ],
  //     level: "A1",
  //     lesson: "Countries",
  //     updateTime: DateTime.now(),
  //   ),
  //   // CLOTHING
  //   WordModel(
  //     id: "clothing",
  //     word: "Clothing",
  //     translations: const [
  //       Translation(word: "Kleidung", language: "German"),
  //       Translation(word: "Clothing", language: "English"),
  //       Translation(word: "Ropa", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Clothing",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "shirt",
  //     word: "Shirt",
  //     translations: const [
  //       Translation(word: "Hemd", language: "German"),
  //       Translation(word: "Shirt", language: "English"),
  //       Translation(word: "Camisa", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Clothing",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "blouse",
  //     word: "Blouse",
  //     translations: const [
  //       Translation(word: "Bluse", language: "German"),
  //       Translation(word: "Blouse", language: "English"),
  //       Translation(word: "Blusa", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Clothing",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "t_shirt",
  //     word: "T-shirt",
  //     translations: const [
  //       Translation(word: "T-Shirt", language: "German"),
  //       Translation(word: "T-shirt", language: "English"),
  //       Translation(word: "Camiseta", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Clothing",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "sweater",
  //     word: "Sweater",
  //     translations: const [
  //       Translation(word: "Pullover", language: "German"),
  //       Translation(word: "Sweater", language: "English"),
  //       Translation(word: "Suéter", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Clothing",
  //     updateTime: DateTime.now(),
  //   ),
  //   // FESTIVAL
  //   WordModel(
  //     id: "festival",
  //     word: "Festival",
  //     translations: const [
  //       Translation(word: "Fest", language: "German"),
  //       Translation(word: "Festival", language: "English"),
  //       Translation(word: "Festival", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Festival",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "birthday",
  //     word: "Birthday",
  //     translations: const [
  //       Translation(word: "Geburtstag", language: "German"),
  //       Translation(word: "Birthday", language: "English"),
  //       Translation(word: "Cumpleaños", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Festival",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "christmas",
  //     word: "Christmas",
  //     translations: const [
  //       Translation(word: "Weihnachten", language: "German"),
  //       Translation(word: "Christmas", language: "English"),
  //       Translation(word: "Navidad", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Festival",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "easter",
  //     word: "Easter",
  //     translations: const [
  //       Translation(word: "Ostern", language: "German"),
  //       Translation(word: "Easter", language: "English"),
  //       Translation(word: "Pascua", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Festival",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "new_years_eve",
  //     word: "New Year's Eve",
  //     translations: const [
  //       Translation(word: "Silvester", language: "German"),
  //       Translation(word: "New Year's Eve", language: "English"),
  //       Translation(word: "Nochevieja", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Festival",
  //     updateTime: DateTime.now(),
  //   ),
  //   // GIFT
  //   WordModel(
  //     id: "gift",
  //     word: "Gift",
  //     translations: const [
  //       Translation(word: "Geschenk", language: "German"),
  //       Translation(word: "Gift", language: "English"),
  //       Translation(word: "Regalo", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Gift",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "to_give",
  //     word: "to give",
  //     translations: const [
  //       Translation(word: "schenken", language: "German"),
  //       Translation(word: "to give", language: "English"),
  //       Translation(word: "regalar", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Gift",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "to_receive",
  //     word: "to receive",
  //     translations: const [
  //       Translation(word: "bekommen", language: "German"),
  //       Translation(word: "to receive", language: "English"),
  //       Translation(word: "recibir", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Gift",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "surprise",
  //     word: "Surprise",
  //     translations: const [
  //       Translation(word: "Überraschung", language: "German"),
  //       Translation(word: "Surprise", language: "English"),
  //       Translation(word: "Sorpresa", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Gift",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "birthday_present",
  //     word: "Birthday present",
  //     translations: const [
  //       Translation(word: "Geburtstagsgeschenk", language: "German"),
  //       Translation(word: "Birthday present", language: "English"),
  //       Translation(word: "Regalo de cumpleaños", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Gift",
  //     updateTime: DateTime.now(),
  //   ),
  //   // FRIEND
  //   WordModel(
  //     id: "friend",
  //     word: "Friend",
  //     translations: const [
  //       Translation(word: "Freund", language: "German"),
  //       Translation(word: "Friend", language: "English"),
  //       Translation(word: "Amigo", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Friend",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "girlfriend",
  //     word: "Girlfriend",
  //     translations: const [
  //       Translation(word: "Freundin", language: "German"),
  //       Translation(word: "Girlfriend", language: "English"),
  //       Translation(word: "Amiga", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Friend",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "acquaintance",
  //     word: "Acquaintance",
  //     translations: const [
  //       Translation(word: "Bekannte", language: "German"),
  //       Translation(word: "Acquaintance", language: "English"),
  //       Translation(word: "Conocido", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Friend",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "pal",
  //     word: "Pal",
  //     translations: const [
  //       Translation(word: "Kumpel", language: "German"),
  //       Translation(word: "Pal", language: "English"),
  //       Translation(word: "Compañero", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Friend",
  //     updateTime: DateTime.now(),
  //   ),
  //   WordModel(
  //     id: "pal_female",
  //     word: "Pal",
  //     translations: const [
  //       Translation(word: "Kumpeline", language: "German"),
  //       Translation(word: "Pal", language: "English"),
  //       Translation(word: "Compañera", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Friend",
  //     updateTime: DateTime.now(),
  //   ),
  //   // SON
  //   WordModel(
  //     id: "son",
  //     word: "Son",
  //     translations: const [
  //       Translation(word: "Sohn", language: "German"),
  //       Translation(word: "Son", language: "English"),
  //       Translation(word: "Hijo", language: "Spanish"),
  //     ],
  //     level: "A2",
  //     lesson: "Parents",
  //     updateTime: DateTime.now(),
  //   ),
  // ];
}
