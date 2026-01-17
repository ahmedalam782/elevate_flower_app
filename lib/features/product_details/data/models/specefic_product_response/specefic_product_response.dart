import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'specefic_product_response.g.dart';

@JsonSerializable()
class SpeceficProductResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "product")
  SpeceficProductDto? product;

  SpeceficProductResponse({this.message, this.product});

  factory SpeceficProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SpeceficProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SpeceficProductResponseToJson(this);
}

@JsonSerializable()
class SpeceficProductDto {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "imgCover")
  String? imgCover;
  @JsonKey(name: "images")
  List<String>? images;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "priceAfterDiscount")
  int? priceAfterDiscount;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "occasion")
  String? occasion;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "isSuperAdmin")
  bool? isSuperAdmin;
  @JsonKey(name: "sold")
  int? sold;
  @JsonKey(name: "rateAvg")
  int? rateAvg;
  @JsonKey(name: "rateCount")
  int? rateCount;
  @JsonKey(name: "favoriteId")
  dynamic favoriteId;
  @JsonKey(name: "isInWishlist")
  bool? isInWishlist;

  SpeceficProductDto({
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
    this.favoriteId,
    this.isInWishlist,
  });

  factory SpeceficProductDto.fromJson(Map<String, dynamic> json) =>
      _$SpeceficProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SpeceficProductDtoToJson(this);

  SpeceficProductEntity toSpeceficProductEntity() {
    return SpeceficProductEntity(
      productId: id ?? "",
      productImages: images ?? [],
      productPrice: price ?? 0,
      productPriceAfterDiscount: priceAfterDiscount ?? 0,
      productName: title ?? "",
      productDescription: description ?? "",
    );
  }
}
