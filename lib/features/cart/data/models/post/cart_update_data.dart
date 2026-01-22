import 'package:json_annotation/json_annotation.dart';

part "cart_update_data.g.dart";

@JsonSerializable()
class CartUpdateDataModel {
  @JsonKey(name: "quantity")
  final int quantity;

  CartUpdateDataModel({required this.quantity});
  Map<String, dynamic> toJson() => _$CartUpdateDataModelToJson(this);
}
