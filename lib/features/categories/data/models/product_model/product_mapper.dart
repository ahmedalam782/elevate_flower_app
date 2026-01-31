import '../../../domain/entities/product_entity.dart';
import 'product_dto.dart';
import 'products_response_models.dart';

/// Convert ProductDto to ProductEntity
extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      images: images ?? const [],
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? price ?? 0,
      discount: discount ?? 0,
      quantity: quantity ?? 0,
      category: category ?? '',
      occasion: occasion ?? '',
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      version: version ?? 0,
      isSuperAdmin: isSuperAdmin ?? false,
      sold: sold ?? 0,
      rateAvg: rateAvg ?? 0,
      rateCount: rateCount ?? 0,
      favoriteId: favoriteId,
      isInWishlist: isInWishlist ?? false,
    );
  }
}


/// Convert ProductsResponseModels to List of ProductEntity
extension ProductsResponseModelMapper on ProductsResponseModels {
  List<ProductEntity> toEntities() {
    if (products == null || products!.isEmpty) return [];
    return products!.map((dto) => dto.toEntity()).toList();
  }
}
