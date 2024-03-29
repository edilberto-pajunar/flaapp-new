class UserModel {
  final String email;
  final String name;

  UserModel({
    required this.email,
    required this.name,
  });

  UserModel copyWith({
    String? email,
    String? name,
  }) =>
      UserModel(
        email: email ?? this.email,
        name: name ?? this.name,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
  };
}
