import '../../../../core/shared/entities/product_item_entity.dart';
import 'product_model.dart';

extension ProductMapper on Product {
  ProductItemEntity toEntity() {
    return ProductItemEntity(
      id: id ?? '',
      price: (price ?? 0).toDouble(),
      description: description,
      priceAfterDiscount: (priceAfterDiscount ?? 0).toDouble(),
      imageUrl: imgCover,
      name: title ?? '',
    );
  }
}
