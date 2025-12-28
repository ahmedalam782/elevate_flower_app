import 'package:json_annotation/json_annotation.dart';

part 'occasion_model.g.dart';

@JsonSerializable()
class OccasionModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String slug;
  final String image;
  final String? createdAt;
  final String? updatedAt;
  final bool isSuperAdmin;

  OccasionModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    this.createdAt,
    this.updatedAt,
    required this.isSuperAdmin,
  });

  factory OccasionModel.fromJson(Map<String, dynamic> json) =>
      _$OccasionModelFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionModelToJson(this);
}