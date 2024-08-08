import 'package:json_annotation/json_annotation.dart';

part 'translation.g.dart';

@JsonSerializable()
class Translation {
  final String word;
  final String language;

  const Translation({
    required this.word,
    required this.language,
  });

  Translation copyWith({
    String? word,
    String? language,
  }) =>
      Translation(
        word: word ?? this.word,
        language: language ?? this.language,
      );

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}
