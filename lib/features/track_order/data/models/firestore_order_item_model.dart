import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreOrderItemModel {
  final String? id;
  final String image;
  final String title;
  final num price;
  final num quantity;

  const FirestoreOrderItemModel({
    this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
  });

  FirestoreOrderItemModel copyWith({
    String? id,
    String? image,
    String? title,
    num? price,
    num? quantity,
  }) {
    return FirestoreOrderItemModel(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  factory FirestoreOrderItemModel.fromJson(Map<String, dynamic> json) {
    return FirestoreOrderItemModel(
      id: json['id']?.toString(),
      image: (json['image'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      price: _parseNumber(json['price']),
      quantity: _parseNumber(json['quantity']),
    );
  }

  factory FirestoreOrderItemModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data == null) {
      throw StateError('Order item document ${document.id} has no data.');
    }

    return FirestoreOrderItemModel.fromJson({
      ...data,
      'id': data['id'] ?? document.id,
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'price': price,
      'quantity': quantity,
    };
  }

  static num _parseNumber(dynamic value) {
    if (value is num) {
      return value;
    }

    if (value is String) {
      return num.tryParse(value) ?? 0;
    }

    return 0;
  }
}
