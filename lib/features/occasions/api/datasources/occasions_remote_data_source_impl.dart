import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/occasions/api/api_client/occasions_api_client.dart';
import 'package:elevate_flower_app/features/occasions/data/datasources/occasions_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/occasions/data/models/occasions_model.dart';
import 'package:elevate_flower_app/features/occasions/data/models/product_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OccasionsRemoteDataSourceContract)
class OccasionsRemoteDataSourceImpl implements OccasionsRemoteDataSourceContract {
  final OccasionsApiClient occasionsApiClient;
  OccasionsRemoteDataSourceImpl(this.occasionsApiClient);

  @override
  Future<Result<OccasionModel>> getAllOccasions()async {
    try {
      final response = await occasionsApiClient.getOccasions();
      return Success<OccasionModel>(data: response);
    }on DioException catch (e) {
      return Error<OccasionModel>(exception: e);
    }on Exception catch (e) {
      return Error<OccasionModel>(exception: e);
    }
  }

  @override
  Future<Result<ProductModel>> getOccasionFlowers(String occasionId) async{
    try {
      final response = await occasionsApiClient.getOccasionFlowers(occasionId);
      return Success<ProductModel>(data: response);
    }on DioException catch (e) {
      return Error<ProductModel>(exception: e);
    }on Exception catch (e) {
      return Error<ProductModel>(exception: e);
    }
  }
}