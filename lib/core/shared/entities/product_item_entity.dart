import 'package:equatable/equatable.dart';

class ProductItemEntity extends Equatable {
  final String id;
  final String? name;
  final String? description;
  final double? price;
  final double? priceAfterDiscount;
  final String? imageUrl;

  const ProductItemEntity({
    required this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.priceAfterDiscount = 0.0,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    priceAfterDiscount,
    imageUrl,
  ];

  ProductItemEntity copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? priceAfterDiscount,
    String? imageUrl,
  }) {
    return ProductItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
