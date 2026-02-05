import '../models/search_response_model.dart';
import '../../domain/entities/search_params.dart';

abstract class SearchRemoteDataSourceContract {
  Future<SearchResponseModel> searchProducts(SearchParams params);
}
