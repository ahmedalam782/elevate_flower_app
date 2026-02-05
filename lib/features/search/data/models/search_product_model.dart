import '../../../../core/shared/entities/product_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_product_model.g.dart';

@JsonSerializable()
class SearchProductModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final double? price;
  final double? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  final bool? isSuperAdmin;
  final int? sold;
  final double? rateAvg;
  final int? rateCount;
  final int? discount;

  SearchProductModel({
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
    this.discount,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      _$SearchProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchProductModelToJson(this);

  ProductItemEntity toEntity() => ProductItemEntity(
    id: id ?? '',
    name: title,
    price: price,
    description: description,
    priceAfterDiscount: priceAfterDiscount,
    imageUrl: imgCover,
  );
}
