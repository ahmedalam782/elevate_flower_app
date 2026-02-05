import '../../../../core/shared/entities/product_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'best_seller_model.g.dart';

@JsonSerializable()
class BestSellerModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final double? price;
  @JsonKey(name: "priceAfterDiscount")
  final double? priceAfterDiscount;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "occasion")
  final String? occasion;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "id")
  final String? bestSellerId;
  @JsonKey(name: "discount")
  final int? discount;

  BestSellerModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.bestSellerId,
    this.discount,
  });

  factory BestSellerModel.fromJson(Map<String, dynamic> json) =>
      _$BestSellerModelFromJson(json);
  ProductItemEntity toEntity() => ProductItemEntity(
    id: id ?? "",
    name: title,
    price: price,
    description: description,
    priceAfterDiscount: priceAfterDiscount,
    imageUrl: imgCover,
  );
}

