import '../../data/models/states_model.dart';
import '../repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetStatesUseCase {
  final AddressDetailsRepository repo;

  GetStatesUseCase({required this.repo});
  Future<List<StatesModel>> call() => repo.getStates();
}
