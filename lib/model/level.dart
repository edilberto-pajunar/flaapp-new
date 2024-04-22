class LevelModel {
  final String id;
  final bool locked;

  LevelModel({
    required this.id,
    this.locked = true,
  });

  LevelModel copyWith({
    String? id,
    bool? locked,
  }) =>
      LevelModel(
        id: id ?? this.id,
        locked: locked ?? this.locked,
      );

  factory LevelModel.fromJson(Map<String, dynamic> json) => LevelModel(
        id: json["id"],
        locked: json["locked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locked": locked,
      };

  static List<LevelModel> levelList = [
    LevelModel(id: "A1", locked: false),
    LevelModel(id: "A2"),
    LevelModel(id: "B1"),
    LevelModel(id: "B2"),
  ];
}
