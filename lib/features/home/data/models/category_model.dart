import 'package:elevate_flower_app/features/home/domain/entities/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? slug;
  final String image;
  final String? createdAt;
  final String? updatedAt;
  final bool? isSuperAdmin;

  CategoryModel({
    required this.id,
    required this.name,
    this.slug,
    required this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryEntity toDomain() => CategoryEntity(id: id, name: name, image: image);
}
