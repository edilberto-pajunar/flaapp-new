class AppUserInfo {
  final String id;
  final String email;
  final String username;

  AppUserInfo({
    required this.id,
    required this.email,
    required this.username,
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

  factory AppUserInfo.fromJson(Map<String, dynamic> json) => AppUserInfo(
        id: json["id"],
        email: json["email"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
      };
}
