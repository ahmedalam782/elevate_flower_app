import '../../domain/entities/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_response.g.dart';

@JsonSerializable(createToJson: false)
class CartResponse {
  CartResponse({
    required this.message,
    required this.numOfCartItems,
    required this.cart,
  });

  final String? message;
  final num? numOfCartItems;
  final Cart? cart;

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  CartEntity toCartEntity() {
    return CartEntity(
      numOfCartItems: numOfCartItems?.toInt() ?? 0,
      totalPrice: cart?.totalPrice?.toDouble() ?? 0,
      cartProducts:
          cart?.cartItems?.map((value) {
            return value.toCartProductEntity();
          }).toList() ??
          [],
    );
  }
}

@JsonSerializable(createToJson: false)
class Cart {
  Cart({
    required this.id,
    required this.user,
    required this.cartItems,
    required this.appliedCoupons,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final List<CartItem>? cartItems;
  final List<dynamic>? appliedCoupons;
  final num? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final num? v;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

@JsonSerializable(createToJson: false)
class CartItem {
  CartItem({
    required this.cartProduct,
    required this.price,
    required this.quantity,
    required this.id,
  });

  @JsonKey(name: 'product')
  final CartProduct? cartProduct;
  final num? price;
  final num? quantity;

  @JsonKey(name: '_id')
  final String? id;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  CartProductEntity toCartProductEntity() {
    return CartProductEntity(
      productName: cartProduct?.title ?? "",
      productDescription: cartProduct?.description ?? "",
      productPrice: price?.toDouble() ?? 0,
      productImage: cartProduct?.imgCover ?? "",
      productQuantityInCart: quantity?.toInt() ?? 0,
      id: cartProduct?.id ?? "",
    );
  }
}

@JsonSerializable(createToJson: false)
class CartProduct {
  CartProduct({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.sold,
    required this.isSuperAdmin,
    required this.rateAvg,
    required this.rateCount,
    required this.cartProductId,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final num? price;
  final num? priceAfterDiscount;
  final num? quantity;
  final String? category;
  final String? occasion;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final num? v;
  final num? sold;
  final bool? isSuperAdmin;
  final num? rateAvg;
  final num? rateCount;
  final String? cartProductId;

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);
}
