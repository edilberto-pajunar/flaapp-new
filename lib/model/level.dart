class LevelModel {
  final String id;
  final bool locked;

  LevelModel({
    required this.id,
    required this.locked,
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
}
