import 'package:elevate_flower_app/features/home/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/home/domain/entities/occasion_entity.dart';
import 'package:elevate_flower_app/features/home/domain/entities/product_entity.dart';


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