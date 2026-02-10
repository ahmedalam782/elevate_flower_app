import 'package:json_annotation/json_annotation.dart';

part 'orders_response.g.dart';

@JsonSerializable()
class OrdersResponse {
  final String message;
  final Metadata metadata;
  final List<dynamic> orders;

  OrdersResponse({
    required this.message,
    required this.metadata,
    required this.orders,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);
}
@JsonSerializable()
class Metadata {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;

  Metadata({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
