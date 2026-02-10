enum OrderStatus {
  pending('pending', 'قيد الانتظار'),//
  processing('processing', 'قيد المعالجة'),//activ
  confirmed('confirmed', 'مؤكد'),
  shipped('shipped', 'تم الشحن'),
  delivered('delivered', 'تم التوصيل'),
  cancelled('cancelled', 'ملغي');

  final String value;
  final String arabicLabel;

  const OrderStatus(this.value, this.arabicLabel);

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => OrderStatus.pending,
    );
  }
}