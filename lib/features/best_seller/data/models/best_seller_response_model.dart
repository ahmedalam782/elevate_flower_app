import 'best_seller_model.dart';
import '../../domain/entities/best_seller_page_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'best_seller_response_model.g.dart';

@JsonSerializable()
class BestSellerResponseModel {
  @JsonKey(name: "message")
  final String? message;
  final Metadata? metadata;
  @JsonKey(name: "bestSeller")
  final List<BestSellerModel>? bestSellerList;

  BestSellerResponseModel({this.message, this.bestSellerList,this.metadata});

  factory BestSellerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BestSellerResponseModelFromJson(json);
  BestSellerPageEntity toEntity() => BestSellerPageEntity(
    products: bestSellerList?.map((e) => e.toEntity()).toList() ?? [],
    currentPage: metadata?.currentPage ,
    totalPages: metadata?.numberOfPages,

  );
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  int? currentPage;
  @JsonKey(name: "numberOfPages")
  int? numberOfPages;
  @JsonKey(name: "limit")
  int? limit;

  Metadata({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
}
