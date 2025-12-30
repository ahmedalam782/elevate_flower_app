import 'package:elevate_flower_app/features/most_seller/data/models/best_seller_model.dart';
import 'package:elevate_flower_app/features/most_seller/domain/entities/best_seller_page_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'best_seller_response_model.g.dart';

@JsonSerializable()
class BestSellerResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "bestSeller")
  final List<BestSellerModel>? bestSellerList;

  BestSellerResponseModel({this.message, this.bestSellerList});

  factory BestSellerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BestSellerResponseModelFromJson(json);
  BestSellerPageEntity toEntity() => BestSellerPageEntity(
    products: bestSellerList?.map((e) => e.toEntity()).toList() ?? []
  );
}
