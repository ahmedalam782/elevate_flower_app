import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreOrderModel {
  final String id;
  final String paymentType;
  final String state;
  final num totalPrice;
  final Timestamp? acceptedAt;
  final Timestamp? arrivedAtPickUpAt;
  final Timestamp? deliveringAt;
  final Timestamp? deliveredAt;
  final Timestamp? completedAt;

  const FirestoreOrderModel({
    required this.id,
    required this.paymentType,
    required this.state,
    required this.totalPrice,
    this.acceptedAt,
    this.arrivedAtPickUpAt,
    this.deliveringAt,
    this.deliveredAt,
    this.completedAt,
  });

  FirestoreOrderModel copyWith({
    String? id,
    String? paymentType,
    String? state,
    num? totalPrice,
    Timestamp? acceptedAt,
    Timestamp? arrivedAtPickUpAt,
    Timestamp? deliveringAt,
    Timestamp? deliveredAt,
    Timestamp? completedAt,
  }) {
    return FirestoreOrderModel(
      id: id ?? this.id,
      paymentType: paymentType ?? this.paymentType,
      state: state ?? this.state,
      totalPrice: totalPrice ?? this.totalPrice,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      arrivedAtPickUpAt: arrivedAtPickUpAt ?? this.arrivedAtPickUpAt,
      deliveringAt: deliveringAt ?? this.deliveringAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory FirestoreOrderModel.fromJson(Map<String, dynamic> json) {
    return FirestoreOrderModel(
      id: (json['id'] ?? '').toString(),
      paymentType: (json['paymentType'] ?? '').toString(),
      state: (json['state'] ?? '').toString(),
      totalPrice: _parseTotalPrice(json['totalPrice']),
      acceptedAt: _parseTimestamp(json['acceptedAt']),
      arrivedAtPickUpAt: _parseTimestamp(json['arrivedAtPickUpAt']),
      deliveringAt: _parseTimestamp(json['deliveringAt']),
      deliveredAt: _parseTimestamp(json['deliveredAt']),
      completedAt: _parseTimestamp(json['completedAt']),
    );
  }

  factory FirestoreOrderModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data == null) {
      throw StateError('Order document ${document.id} has no data.');
    }

    return FirestoreOrderModel.fromJson({
      ...data,
      'id': data['id'] ?? document.id,
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paymentType': paymentType,
      'state': state,
      'totalPrice': totalPrice,
      'acceptedAt': acceptedAt,
      'arrivedAtPickUpAt': arrivedAtPickUpAt,
      'deliveringAt': deliveringAt,
      'deliveredAt': deliveredAt,
      'completedAt': completedAt,
    };
  }

  static num _parseTotalPrice(dynamic value) {
    if (value is num) {
      return value;
    }

    if (value is String) {
      return num.tryParse(value) ?? 0;
    }

    return 0;
  }

  static Timestamp? _parseTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) {
      return value;
    }

    return null;
  }
}
