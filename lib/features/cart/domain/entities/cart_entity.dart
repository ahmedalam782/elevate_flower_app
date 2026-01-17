import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartEntity {
  int numOfCartItems;
  double totalPrice;
  List<CartProductEntity> cartProducts;
  CartEntity({
    required this.numOfCartItems,
    required this.totalPrice,
    required this.cartProducts,
  });

  @override
  bool operator ==(covariant CartEntity other) {
    if (identical(this, other)) return true;

    return other.numOfCartItems == numOfCartItems &&
        other.totalPrice == totalPrice &&
        listEquals(other.cartProducts, cartProducts);
  }

  @override
  int get hashCode =>
      numOfCartItems.hashCode ^ totalPrice.hashCode ^ cartProducts.hashCode;

  CartEntity copyWith({
    int? numOfCartItems,
    double? totalPrice,
    List<CartProductEntity>? cartProducts,
  }) {
    return CartEntity(
      numOfCartItems: numOfCartItems ?? this.numOfCartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      cartProducts: cartProducts ?? this.cartProducts,
    );
  }
}

class CartProductEntity {
  String id;
  String productName;
  String productDescription;
  double productPrice;
  String productImage;
  int productQuantityInCart;

  CartProductEntity({
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.productQuantityInCart,
  });

  @override
  bool operator ==(covariant CartProductEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productName == productName &&
        other.productDescription == productDescription &&
        other.productPrice == productPrice &&
        other.productImage == productImage &&
        other.productQuantityInCart == productQuantityInCart;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productName.hashCode ^
        productDescription.hashCode ^
        productPrice.hashCode ^
        productImage.hashCode ^
        productQuantityInCart.hashCode;
  }

  CartProductEntity copyWith({
    String? id,
    String? productName,
    String? productDescription,
    double? productPrice,
    String? productImage,
    int? productQuantityInCart,
  }) {
    return CartProductEntity(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      productQuantityInCart:
          productQuantityInCart ?? this.productQuantityInCart,
    );
  }
}
