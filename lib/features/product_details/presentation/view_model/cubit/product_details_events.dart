// TODO: presentation Product_detailsEvents

sealed class ProductDetailsEvents {}

class GetSpeceficProductEvent extends ProductDetailsEvents {
  final String productId;

  GetSpeceficProductEvent({required this.productId});
}
