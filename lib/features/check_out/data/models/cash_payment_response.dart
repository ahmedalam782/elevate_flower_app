import 'package:json_annotation/json_annotation.dart';
part 'cash_payment_response.g.dart';

@JsonSerializable()
class CashPaymentResponse {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'order')
  Order? order;

  CashPaymentResponse({this.message, this.order});

  factory CashPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$CashPaymentResponseFromJson(json);

  static List<CashPaymentResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(CashPaymentResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$CashPaymentResponseToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: 'user')
  String? user;
  @JsonKey(name: 'orderItems')
  List<OrderItems>? orderItems;
  @JsonKey(name: 'totalPrice')
  int? totalPrice;
  @JsonKey(name: 'paymentType')
  String? paymentType;
  @JsonKey(name: 'isPaid')
  bool? isPaid;
  @JsonKey(name: 'isDelivered')
  bool? isDelivered;
  @JsonKey(name: 'state')
  String? state;
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'orderNumber')
  String? orderNumber;
  @JsonKey(name: '__v')
  int? v;

  Order({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  static List<Order> fromList(List<Map<String, dynamic>> list) {
    return list.map(Order.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItems {
  @JsonKey(name: 'product')
  Product? product;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: '_id')
  String? id;

  OrderItems({this.product, this.price, this.quantity, this.id});

  factory OrderItems.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsFromJson(json);

  static List<OrderItems> fromList(List<Map<String, dynamic>> list) {
    return list.map(OrderItems.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'imgCover')
  String? imgCover;
  @JsonKey(name: 'images')
  List<String>? images;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'priceAfterDiscount')
  int? priceAfterDiscount;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'occasion')
  String? occasion;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  @JsonKey(name: 'isSuperAdmin')
  bool? isSuperAdmin;
  @JsonKey(name: 'sold')
  int? sold;
  @JsonKey(name: 'rateAvg')
  int? rateAvg;
  @JsonKey(name: 'rateCount')
  int? rateCount;

  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  static List<Product> fromList(List<Map<String, dynamic>> list) {
    return list.map(Product.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
