
import 'package:equatable/equatable.dart';

import '../../data/models/shipping_address_model.dart';

class AddressEntity extends Equatable{
  final String? street;
  final String? city;
  final String? lat;
  final String? long;
  final String? id;
  final String? phone;

  const AddressEntity({
    required this.street,
    required this.city,
    required this.lat,
    required this.long,
    required this.id,
    required this.phone,
  });
  
  @override
  List<Object?> get props => [
    street,
    city,
    lat,
    long,
    id,
    phone,
  ];
}
extension AddressEntityExtension on AddressEntity {
  ShippingAddressModel toModel() {
    return ShippingAddressModel(
      street: street ?? '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      phone: phone ?? '',
      id: id,

    );
  }
}
