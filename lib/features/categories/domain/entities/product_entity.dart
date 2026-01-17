class ProductEntity {
  final String id;
  final String title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final double? price;
  final double? priceAfterDiscount;
  final double? discount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;
  final bool? isSuperAdmin;
  final int? sold;
  final double? rateAvg;
  final int? rateCount;
  final String? favoriteId;
  final bool? isInWishlist;

  ProductEntity({
    required this.id,
    required this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.favoriteId,
    this.isInWishlist,
  });
}
