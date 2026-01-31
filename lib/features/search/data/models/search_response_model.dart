import 'search_product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response_model.g.dart';

@JsonSerializable()
class SearchResponseModel {
  final String? message;
  final SearchMetadata? metadata;
  final List<SearchProductModel>? products;

  SearchResponseModel({this.message, this.products, this.metadata});

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseModelToJson(this);
}

@JsonSerializable()
class SearchMetadata {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;

  SearchMetadata({this.currentPage, this.numberOfPages, this.limit});

  factory SearchMetadata.fromJson(Map<String, dynamic> json) =>
      _$SearchMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMetadataToJson(this);
}
