import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class AppUserInfo extends Equatable {
  final String? id;
  final String? email;
  final String? username;
  final String? language;
  final String? code;
  final String? codeToLearn;
  final String? role;

  const AppUserInfo({
    this.id,
    this.email,
    this.username,
    this.language,
    this.code,
    this.codeToLearn,
    this.role,
  });

  AppUserInfo copyWith({
    String? id,
    String? email,
    String? username,
    String? language,
    String? code,
    String? codeToLearn,
    String? role,
  }) =>
      AppUserInfo(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        language: language ?? this.language,
        code: code ?? this.code,
        codeToLearn: codeToLearn ?? this.codeToLearn,
        role: role ?? this.role,
      );

  factory AppUserInfo.fromJson(Map<String, dynamic> json) =>
      _$AppUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserInfoToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        language,
        code,
        codeToLearn,
        role,
      ];
}
