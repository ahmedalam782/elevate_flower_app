class BestSellerProductEntity {
  final String? id;
  final String? title;
  final int? priceBeforeDiscount;
  final int? priceAfterDiscount;
  final String? coverImage;
  
  const BestSellerProductEntity({
    this.id,
    this.title,
    this.coverImage,
    this.priceBeforeDiscount,
    this.priceAfterDiscount,
  });
}
