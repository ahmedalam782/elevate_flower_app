import 'package:elevate_flower_app/features/home/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int? discount;
  final int quantity;
  final String category;
  final String occasion;
  final String createdAt;
  final String updatedAt;
  final bool isSuperAdmin;
  final int? sold;
  final num rateAvg;
  final int rateCount;

  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    this.discount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    this.sold,
    required this.rateAvg,
    required this.rateCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);


  ProductEntity toDomain() => ProductEntity(
  id: id,
  title: title,
  description: description,
  imgCover: imgCover,
  images: images,
  price: price,
  priceAfterDiscount: priceAfterDiscount,
  quantity: quantity,
);
}