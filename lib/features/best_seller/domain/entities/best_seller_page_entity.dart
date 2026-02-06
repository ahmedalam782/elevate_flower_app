import '../../../../core/shared/entities/product_item_entity.dart';

class BestSellerPageEntity {
  final List<ProductItemEntity>? products;
  final int? currentPage;
  final int? totalPages;
  const BestSellerPageEntity({this.products, this.currentPage, this.totalPages});
}
