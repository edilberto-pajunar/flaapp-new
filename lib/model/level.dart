class LevelModel {
  final String label;
  final bool locked;
  final String? id;

  LevelModel({
    required this.label,
    this.locked = true,
    this.id,
  });

  LevelModel copyWith({
    String? label,
    bool? locked,
    String? id,
  }) =>
      LevelModel(
        label: label ?? this.label,
        locked: locked ?? this.locked,
        id: id ?? this.id,
      );

  factory LevelModel.fromJson(Map<String, dynamic> json) => LevelModel(
        label: json["label"],
        locked: json["locked"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "locked": locked,
        "id": id,
      };

  static List<LevelModel> levelList = [
    LevelModel(label: "A1", locked: false),
    LevelModel(label: "A2"),
    LevelModel(label: "B1"),
    LevelModel(label: "B2"),
  ];
}
