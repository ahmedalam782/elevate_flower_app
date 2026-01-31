import 'category_entity.dart';
import 'occasion_entity.dart';
import 'product_entity.dart';


class HomeEntity {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final List<ProductEntity> bestSeller;
  final List<OccasionEntity> occasions;

  HomeEntity({
    required this.products,
    required this.categories,
    required this.bestSeller,
    required this.occasions,
  });
}