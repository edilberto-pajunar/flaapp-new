import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'level.g.dart';

@JsonSerializable(explicitToJson: true)
class LevelModel extends Equatable {
  final String label;
  final bool locked;
  final String id;

  const LevelModel({
    required this.label,
    this.locked = true,
    required this.id,
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

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelModelToJson(this);

  @override
  List<Object?> get props => [
        label,
        locked,
        id,
      ];
}
