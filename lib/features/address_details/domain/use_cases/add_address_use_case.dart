import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/domain/repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUseCase {
  final AddressDetailsRepository addressDetailsRepository;

  AddAddressUseCase({required this.addressDetailsRepository});
  Future<Result<void>> call(AddressDetailsData data) =>
      addressDetailsRepository.addAddressDetails(data);
}
