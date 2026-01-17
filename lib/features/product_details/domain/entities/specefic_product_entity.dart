class SpeceficProductEntity {
  final String productId;
  final List<String> productImages;
  final num productPrice;
  final num productPriceAfterDiscount;
  final String productName;
  final String productDescription;

  SpeceficProductEntity({
    required this.productId,
    required this.productImages,
    required this.productPrice,
    required this.productPriceAfterDiscount,
    required this.productName,
    required this.productDescription,
  });
}
