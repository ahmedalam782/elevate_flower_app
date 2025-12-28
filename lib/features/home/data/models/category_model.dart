import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String slug;
  final String image;
  final String? createdAt;
  final String? updatedAt;
  final bool isSuperAdmin;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    this.createdAt,
    this.updatedAt,
    required this.isSuperAdmin,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}