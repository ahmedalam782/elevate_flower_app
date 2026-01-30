import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:elevate_flower_app/features/address_details/domain/repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetStatesUseCase {
  final AddressDetailsRepository repo;

  GetStatesUseCase({required this.repo});
  Future<List<StatesModel>> call() => repo.getStates();
}
