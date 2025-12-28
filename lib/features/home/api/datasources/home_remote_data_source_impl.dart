// TODO: api HomeRemoteDataSourceImpl
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/home/api/api_client/home_api_client.dart';
import 'package:elevate_flower_app/features/home/data/datasources/home_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/home/data/models/home_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDatasourceImpl implements HomeRemoteDataSourceContract {
  HomeRemoteDatasourceImpl(this.homeApiClient);
  final HomeApiClient homeApiClient;

  @override
  Future<Result<HomeResponse>> getHomeData()async {
   try {
      HomeResponse response=await homeApiClient.getHomeData();
    return Success<HomeResponse>(data: response);
   } catch (e) {
     return Error<HomeResponse>(exception: Exception(e.toString()));
   }

  }}

 