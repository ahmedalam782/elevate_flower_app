import 'package:elevate_flower_app/features/orders_page/data/models/orders_response.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/order_entity.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/orders_entity.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/pagination_entity.dart';

extension OrdersResponseMapper on OrdersResponse {
  OrdersEntity toEntity() {
    return OrdersEntity(
      message: message,
      pagination: metadata.toEntity(),
      orders: orders
          .map((orderJson) => OrderEntity.fromJson(orderJson as Map<String, dynamic>))
          .toList(),
    );
  }
}

extension MetadataMapper on Metadata {
  PaginationEntity toEntity() {
    return PaginationEntity(
      currentPage: currentPage,
      totalPages: totalPages,
      limit: limit,
      totalItems: totalItems,
    );
  }
}