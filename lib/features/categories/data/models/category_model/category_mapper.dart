import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'category_dto.dart';
import 'category_response_model.dart';

/// Convert CategoryDto to CategoryEntity
extension CategoryDtoMapper on CategoryDto {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isSuperAdmin: isSuperAdmin,
      productsCount: productsCount,
    );
  }
}

/// Convert CategoryResponseModel to List of CategoryEntity
extension CategoryResponseModelMapper on CategoryResponseModel {
  List<CategoryEntity> toEntities() {
    return categories.map((dto) => dto.toEntity()).toList();
  }
}