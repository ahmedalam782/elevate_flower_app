// في ملف orders_entity.dart
import 'package:equatable/equatable.dart';
import 'order_entity.dart';
import 'pagination_entity.dart';

class OrdersEntity extends Equatable {
  final String message;
  final PaginationEntity pagination;
  final List<OrderEntity> orders;

  const OrdersEntity({
    required this.message,
    required this.pagination,
    required this.orders,
  });

  // ✅ أضيفي الـ factory method ده
  factory OrdersEntity.fromJson(Map<String, dynamic> json) {
    return OrdersEntity(
      message: json['message'] as String,
      pagination: PaginationEntity.fromJson(json['metadata'] as Map<String, dynamic>),
      orders: (json['orders'] as List)
          .map((orderJson) => OrderEntity.fromJson(orderJson as Map<String, dynamic>))
          .toList(),
    );
  }

  bool get isEmpty => orders.isEmpty;
  bool get isNotEmpty => orders.isNotEmpty;
  int get ordersCount => orders.length;

  @override
  List<Object?> get props => [message, pagination, orders];
}