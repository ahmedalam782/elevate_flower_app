class ShippingAddressModel {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String? id;

  ShippingAddressModel({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long, this.id,
  });

  Map<String, dynamic> toJson() {
    return { 
        "shippingAddress": {
          'street': street,
          'phone': phone,
          'city': city,
          'lat': lat,
          'long': long,
        }
    };
  }
}