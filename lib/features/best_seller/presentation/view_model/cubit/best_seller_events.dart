sealed class BestSellerEvents {
  const BestSellerEvents();
  factory BestSellerEvents.getBestSellerProducts() = GetBestSellerProductsEvent;

  void when({required void Function() getBestSellerProducts}) {
    if (this is GetBestSellerProductsEvent) {
      getBestSellerProducts();
    }
  }
}

class GetBestSellerProductsEvent extends BestSellerEvents {}
