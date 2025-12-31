import 'package:elevate_flower_app/features/most_seller/domain/entities/best_seller_product_entity.dart';

class BestSellerPageEntity {
  final List<BestSellerProductEntity>? products;
  final int? currentPage;
  final int? totalPages;
  const BestSellerPageEntity({this.products, this.currentPage, this.totalPages});
}
