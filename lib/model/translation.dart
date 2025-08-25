import 'package:json_annotation/json_annotation.dart';

part 'translation.g.dart';

@JsonSerializable()
class Translation {
  final String? word;
  final String? language;
  final String? code;

  const Translation({
    this.word,
    this.language,
    this.code,
  });

  Translation copyWith({
    String? word,
    String? language,
    String? code,
  }) =>
      Translation(
        word: word ?? this.word,
        language: language ?? this.language,
        code: code ?? this.code,
      );

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}
