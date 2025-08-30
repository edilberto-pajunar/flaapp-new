import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class LanguageModel {
  final String? id;
  final String? language;
  final String? code;
  final DateTime? createdAt;
  final String? flag;

  const LanguageModel({
    this.id,
    this.language,
    this.code,
    this.createdAt,
    this.flag,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);
}
