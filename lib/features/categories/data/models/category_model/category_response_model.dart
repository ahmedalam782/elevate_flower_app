import 'category_dto.dart';
import 'metadata_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response_model.g.dart';

@JsonSerializable()
class CategoryResponseModel {
  final String? message;
  final MetadataModel? metadata;
  final List<CategoryDto>? categories;

  CategoryResponseModel({
    this.message,
    this.metadata,
    this.categories,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseModelToJson(this);
}
