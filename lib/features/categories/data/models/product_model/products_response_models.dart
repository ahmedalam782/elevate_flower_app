import 'package:json_annotation/json_annotation.dart';
import 'metadata_model.dart';
import 'product_dto.dart';

part 'products_response_models.g.dart';

@JsonSerializable()
class ProductsResponseModels {
  final String message;
  final MetadataModel metadata;
  final List<ProductDto> products;

  ProductsResponseModels({
    required this.message,
    required this.metadata,
    required this.products,
  });

  factory ProductsResponseModels.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseModelsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseModelsToJson(this);
}
