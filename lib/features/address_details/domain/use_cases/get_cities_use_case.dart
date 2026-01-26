import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/domain/repositories/address_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCitiesUseCase {
  final AddressDetailsRepository repo;

  GetCitiesUseCase({required this.repo});
  Future<List<CityModel>> call() => repo.getAllCities();
}
