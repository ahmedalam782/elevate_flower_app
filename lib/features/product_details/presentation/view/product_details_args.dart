/// Arguments passed (via GoRouter `extra`) when opening the product details
/// page. [imageUrl] is the image already shown on the tapped card, so the
/// details page can show it immediately and let the Hero animation start
/// before the product data finishes loading.
class ProductDetailsArgs {
  final String id;
  final String? imageUrl;

  const ProductDetailsArgs({required this.id, this.imageUrl});
}
