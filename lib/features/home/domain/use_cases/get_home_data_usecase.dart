import '../../../../core/config/base_response/result.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeDataUsecase {
  final HomeRepository _homeRepository;

  GetHomeDataUsecase(HomeRepository homeRepository)
    : _homeRepository = homeRepository;

  Future<Result<HomeEntity>> call() => _homeRepository.getHomeData();
}
