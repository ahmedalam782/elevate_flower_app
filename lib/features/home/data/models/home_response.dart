import 'package:json_annotation/json_annotation.dart';
import 'product_model.dart';
import 'category_model.dart';
import 'occasion_model.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  final String message;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final List<ProductModel> bestSeller;
  final List<OccasionModel> occasions;

  HomeResponse({
    required this.message,
    required this.products,
    required this.categories,
    required this.bestSeller,
    required this.occasions,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}