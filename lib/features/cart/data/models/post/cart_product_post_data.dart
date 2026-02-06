import 'package:json_annotation/json_annotation.dart';

part "cart_product_post_data.g.dart";

@JsonSerializable()
class CartProductPostData {
  @JsonKey(name: "product")
  String product;
  @JsonKey(name: "quantity")
  int quantity;

  CartProductPostData({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() => _$CartProductPostDataToJson(this);
}
