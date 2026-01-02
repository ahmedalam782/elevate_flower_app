import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/home/domain/entities/home_entity.dart';
import 'package:elevate_flower_app/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeDataUsecase {
  final HomeRepository _homeRepository;

  GetHomeDataUsecase(HomeRepository homeRepository)
    : _homeRepository = homeRepository;

  Future<Result<HomeEntity>> call() => _homeRepository.getHomeData();
}
