import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'category_dto.dart';
import 'category_response_model.dart';

/// Convert CategoryDto to CategoryEntity
extension CategoryDtoMapper on CategoryDto {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id ?? "",
      name: name ?? "",
      slug: slug ?? "",
      image: image ?? "",
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      isSuperAdmin: isSuperAdmin ?? false,
      productsCount: productsCount ?? 0,
    );
  }
}

/// Convert CategoryResponseModel to List of CategoryEntity
extension CategoryResponseModelMapper on CategoryResponseModel {
  List<CategoryEntity> toEntities() {
    if (categories == null || categories!.isEmpty) return [];
    return categories!.map((dto) => dto.toEntity()).toList();
  }
}
