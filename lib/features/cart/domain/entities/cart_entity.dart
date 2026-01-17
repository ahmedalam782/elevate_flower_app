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
}

class CartProductEntity {
  String productName;
  String productDescription;
  double productPrice;
  String productImage;
  int productQuantityInCart;

  CartProductEntity({
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.productQuantityInCart,
  });

  @override
  bool operator ==(covariant CartProductEntity other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.productDescription == productDescription &&
        other.productPrice == productPrice &&
        other.productImage == productImage &&
        other.productQuantityInCart == productQuantityInCart;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        productDescription.hashCode ^
        productPrice.hashCode ^
        productImage.hashCode ^
        productQuantityInCart.hashCode;
  }
}
