import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/domain/repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressUseCase {
  final AddressDetailsRepository addressDetailsRepository;

  UpdateAddressUseCase({required this.addressDetailsRepository});
  Future<Result<void>> call(AddressDetailsData data, String id) =>
      addressDetailsRepository.updateAddress(data, id);
}
