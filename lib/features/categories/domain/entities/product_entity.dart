/// Domain Entity for Product
/// This represents the business model, independent of data sources
class ProductEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final double price;
  final double priceAfterDiscount;
  final double? discount;
  final int quantity;
  final String category;
  final String occasion;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final bool? isSuperAdmin;
  final int? sold;
  final double rateAvg;
  final int rateCount;
  final String? favoriteId;
  final bool isInWishlist;

  ProductEntity({
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
    required this.version,
    this.isSuperAdmin,
    this.sold,
    required this.rateAvg,
    required this.rateCount,
    this.favoriteId,
    required this.isInWishlist,
  });

  /// Copy with method for immutability
  ProductEntity copyWith({
    String? id,
    String? title,
    String? slug,
    String? description,
    String? imgCover,
    List<String>? images,
    double? price,
    double? priceAfterDiscount,
    double? discount,
    int? quantity,
    String? category,
    String? occasion,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    bool? isSuperAdmin,
    int? sold,
    double? rateAvg,
    int? rateCount,
    String? favoriteId,
    bool? isInWishlist,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      imgCover: imgCover ?? this.imgCover,
      images: images ?? this.images,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      discount: discount ?? this.discount,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      occasion: occasion ?? this.occasion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      sold: sold ?? this.sold,
      rateAvg: rateAvg ?? this.rateAvg,
      rateCount: rateCount ?? this.rateCount,
      favoriteId: favoriteId ?? this.favoriteId,
      isInWishlist: isInWishlist ?? this.isInWishlist,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductEntity &&
        other.id == id &&
        other.title == title &&
        other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'ProductEntity(id: $id, title: $title, price: $price, priceAfterDiscount: $priceAfterDiscount)';
  }
}