class ProductEntity {
  final String id;
  final String title;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
  });
}