import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class AppUserInfo {
  final String? id;
  final String? email;
  final String? username;

  AppUserInfo({
    this.id,
    this.email,
    this.username,
  });

  AppUserInfo copyWith({
    String? id,
    String? email,
    String? username,
  }) =>
      AppUserInfo(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
      );

  factory AppUserInfo.fromJson(Map<String, dynamic> json) =>
      _$AppUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserInfoToJson(this);
}
