class ProductCardEntity {
  String? id;
  String? title;
  String? description;
  String? imgCover;
  List<String>? images;
  int? price;
  int? priceAfterDiscount;
  int? discount;
  int? rateAvg;
  int? rateCount;
  int? quantity;
  String? category;
  String? occasion;
  bool? isInWishlist;
  ProductCardEntity({
    this.id,
    this.title,
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
    this.isInWishlist,
  });
}
