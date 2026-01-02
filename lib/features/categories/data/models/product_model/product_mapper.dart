import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';
import 'product_dto.dart';
import 'products_response_models.dart';

/// Convert ProductDto to ProductEntity
extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      discount: discount,
      quantity: quantity,
      category: category,
      occasion: occasion,
      createdAt: createdAt,
      updatedAt: updatedAt,
      version: version,
      isSuperAdmin: isSuperAdmin,
      sold: sold,
      rateAvg: rateAvg,
      rateCount: rateCount,
      favoriteId: favoriteId,
      isInWishlist: isInWishlist,
    );
  }
}

/// Convert ProductsResponseModels to List of ProductEntity
extension ProductsResponseModelMapper on ProductsResponseModels {
  List<ProductEntity> toEntities() {
    return products.map((dto) => dto.toEntity()).toList();
  }
}