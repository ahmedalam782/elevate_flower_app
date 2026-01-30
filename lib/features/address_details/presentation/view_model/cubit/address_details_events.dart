// TODO: presentation Address_detailsEvents

sealed class AddressDetailsEvents {}

class AdddAddressEvent extends AddressDetailsEvents {}

class UpdateAddressEvent extends AddressDetailsEvents {
  final String id;

  UpdateAddressEvent({required this.id});
}
