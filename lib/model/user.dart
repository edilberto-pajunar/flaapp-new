import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class AppUserInfo {
  final String? id;
  final String? email;
  final String? username;
  final String? language;
  final String? code;
  final String? codeToLearn;

  AppUserInfo({
    this.id,
    this.email,
    this.username,
    this.language,
    this.code,
    this.codeToLearn,
  });

  AppUserInfo copyWith({
    String? id,
    String? email,
    String? username,
    String? language,
    String? code,
    String? codeToLearn,
  }) =>
      AppUserInfo(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        language: language ?? this.language,
        code: code ?? this.code,
        codeToLearn: codeToLearn ?? this.codeToLearn,
      );

  factory AppUserInfo.fromJson(Map<String, dynamic> json) =>
      _$AppUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserInfoToJson(this);
}
