// TODO: domain HomeRepository
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/home/data/datasources/home_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
 Future<Result<HomeEntity>>getHomeData();
}