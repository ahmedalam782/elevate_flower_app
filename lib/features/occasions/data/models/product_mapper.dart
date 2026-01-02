import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/occasions/data/models/product_model.dart';

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
