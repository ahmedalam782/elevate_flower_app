 sealed class MostSellerEvents {
  const MostSellerEvents();
  factory MostSellerEvents.getBestSellerProducts() = GetBestSellerProductsEvent;

  void when({
    required void Function() getBestSellerProducts,
  }) {
    if (this is GetBestSellerProductsEvent) {
      getBestSellerProducts();
    }
  }
}

class GetBestSellerProductsEvent extends MostSellerEvents {
} 