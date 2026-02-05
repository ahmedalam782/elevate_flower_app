import '../api_client/search_api_client.dart';
import '../../data/datasources/search_remote_data_source_contract.dart';
import '../../data/models/search_response_model.dart';
import '../../domain/entities/search_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRemoteDataSourceContract)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSourceContract {
  final SearchApiClient _apiClient;

  SearchRemoteDataSourceImpl(this._apiClient);

  @override
  Future<SearchResponseModel> searchProducts(SearchParams params) async {
    return await _apiClient.searchProducts(
      params.keyword,
      params.page,
      params.limit,
    );
  }
}
