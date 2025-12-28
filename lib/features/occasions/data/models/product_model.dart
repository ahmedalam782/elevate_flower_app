import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'metadata')
  Metadata? metadata;
  @JsonKey(name: 'products')
  List<Product>? products;

  ProductModel({this.message, this.metadata, this.products});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  static List<ProductModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProductModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'imgCover')
  String? imgCover;
  @JsonKey(name: 'images')
  List<String>? images;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'priceAfterDiscount')
  int? priceAfterDiscount;
  @JsonKey(name: 'discount')
  int? discount;
  @JsonKey(name: 'rateAvg')
  int? rateAvg;
  @JsonKey(name: 'rateCount')
  int? rateCount;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'occasion')
  String? occasion;
  @JsonKey(name: 'isSuperAdmin')
  bool? isSuperAdmin;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  @JsonKey(name: 'favoriteId')
  dynamic favoriteId;
  @JsonKey(name: 'isInWishlist')
  bool? isInWishlist;

  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.favoriteId,
    this.isInWishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  static List<Product> fromList(List<Map<String, dynamic>> list) {
    return list.map(Product.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: 'currentPage')
  int? currentPage;
  @JsonKey(name: 'totalPages')
  int? totalPages;
  @JsonKey(name: 'limit')
  int? limit;
  @JsonKey(name: 'totalItems')
  int? totalItems;

  Metadata({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  static List<Metadata> fromList(List<Map<String, dynamic>> list) {
    return list.map(Metadata.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
