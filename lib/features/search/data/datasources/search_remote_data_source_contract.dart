import 'package:elevate_flower_app/features/search/data/models/search_response_model.dart';
import 'package:elevate_flower_app/features/search/domain/entities/search_params.dart';

abstract class SearchRemoteDataSourceContract {
  Future<SearchResponseModel> searchProducts(SearchParams params);
}
