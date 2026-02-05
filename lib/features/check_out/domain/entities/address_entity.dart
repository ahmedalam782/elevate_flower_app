
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:equatable/equatable.dart';


class AddressEntity extends Equatable {
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
  List<Object?> get props => [street, city, lat, long, id, phone];
}

extension AddressEntityExtension on AddressEntity {
  AddressDetailsData toAddressDetailsData() {
    return AddressDetailsData(
      street: street ?? '',
      addressId: id ?? '',
      username: '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      phone: phone ?? '',
    );
  }

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
