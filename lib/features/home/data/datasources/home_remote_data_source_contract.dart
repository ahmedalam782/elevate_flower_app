// TODO: data HomeRemoteDataSourceContract

import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/home/data/models/home_response.dart';


abstract class HomeRemoteDataSourceContract {
  Future<Result<HomeResponse>> getHomeData();
}