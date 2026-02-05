import '../../../../core/config/base_response/result.dart';
import '../../data/models/address_details_data.dart';
import '../repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUseCase {
  final AddressDetailsRepository addressDetailsRepository;

  AddAddressUseCase({required this.addressDetailsRepository});
  Future<Result<void>> call(AddressDetailsData data) =>
      addressDetailsRepository.addAddressDetails(data);
}
