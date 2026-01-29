// TODO: presentation Address_detailsEvents

import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';

sealed class AddressDetailsEvents {}

class AdddAddressEvent extends AddressDetailsEvents {}

class UpdateAddressEvent extends AddressDetailsEvents {
  final String id;

  UpdateAddressEvent({required this.id});
}
