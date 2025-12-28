import 'package:elevate_flower_app/features/occasions/data/models/product_model.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/product_card_entity.dart';

extension ProductMapper on Product {
  ProductCardEntity toEntity() {
    return ProductCardEntity(
      id: id,
      title: title,
      price: price,
      images: images,
      description: description,
      imgCover: imgCover,
      category: category,
      occasion: occasion,
      discount: discount,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      rateAvg: rateAvg,
      isInWishlist: isInWishlist,
      rateCount: rateCount,
    );
  }
}
