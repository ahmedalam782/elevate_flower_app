import '../../data/models/cities_model.dart';
import '../repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCitiesUseCase {
  final AddressDetailsRepository repo;

  GetCitiesUseCase({required this.repo});
  Future<List<CityModel>> call() => repo.getAllCities();
}
