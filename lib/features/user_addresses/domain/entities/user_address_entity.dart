import '../../../address_details/data/models/address_details_data.dart';

class UserAddressEntity {
  final String? street;
  final String? city;
  final String? id;
  final String? username;
  final String? lat;
  final String? long;
  final String? phone;

  UserAddressEntity({
    this.street,
    this.city,
    this.id,
    this.username,
    this.lat,
    this.long,
    this.phone,
  });

  AddressDetailsData toAddressDetailsData() {
    return AddressDetailsData(
      addressId: id,
      city: city,
      lat: lat,
      long: long,
      phone: phone,
      street: street,
      username: username,
    );
  }
}
