
import 'package:elevate_flower_app/features/orders_page/domain/entities/order_status.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final String productName;
  final double price;
  final String currency;
  final String? imageUrl;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? deliveredAt;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.productName,
    required this.price,
    this.currency = 'EGP',
    this.imageUrl,
    required this.status,
    required this.createdAt,
    this.deliveredAt,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    // ✅ الـ API بيرجع المنتجات في orderItems كـ List
    // بناخد أول منتج عشان نعرض اسمه وصورته
    final orderItems = json['orderItems'] as List? ?? [];
    final firstItem = orderItems.isNotEmpty
        ? orderItems[0] as Map<String, dynamic>
        : null;
    final product = firstItem != null
        ? firstItem['product'] as Map<String, dynamic>?
        : null;

    return OrderEntity(
      // ✅ الـ API بيرجع _id مش id
      id: (json['_id'] ?? '').toString(),

      // ✅ الـ API بيرجع orderNumber مباشرة
      orderNumber: (json['orderNumber'] ?? '').toString(),

      // ✅ الاسم جوه orderItems[0].product.title
      productName: (product?['title'] ?? 'Unknown Product').toString(),

      // ✅ السعر الكلي للأوردر
      price: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,

      currency: 'EGP',

      // ✅ الصورة جوه orderItems[0].product.imgCover
      imageUrl: product?['imgCover'] as String?,

      // ✅ الـ status اسمه 'state' مش 'status' في الـ API
      status: OrderStatus.fromString(
        (json['state'] as String?) ?? 'pending',
      ),

      // ✅ createdAt موجود مباشرة
      createdAt: _parseDate(json['createdAt']),
      deliveredAt: json['deliveredAt'] != null
          ? _parseDate(json['deliveredAt'])
          : null,
    );
  }

  static DateTime _parseDate(dynamic dateValue) {
    if (dateValue == null) return DateTime.now();
    try {
      return DateTime.parse(dateValue.toString());
    } catch (_) {
      return DateTime.now();
    }
  }

  // ✅ لو الأوردر فيه أكتر من منتج يعرض عددهم
  static String getProductName(List orderItems) {
    if (orderItems.isEmpty) return 'Unknown Product';
    final firstProduct = (orderItems[0] as Map)['product'] as Map?;
    final title = firstProduct?['title'] ?? 'Unknown Product';
    if (orderItems.length > 1) {
      return '$title +${orderItems.length - 1} more';
    }
    return title.toString();
  }

  String get formattedPrice => 'EGP ${price.toStringAsFixed(0)}';
  String get formattedOrderNumber => orderNumber;

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        productName,
        price,
        currency,
        imageUrl,
        status,
        createdAt,
        deliveredAt,
      ];
}