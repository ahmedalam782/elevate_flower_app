import '../../../../core/config/api/api_executer.dart';
import '../../../../core/config/base_response/result.dart';
import '../../../../core/shared/entities/product_item_entity.dart';
import '../datasources/search_remote_data_source_contract.dart';
import '../../domain/entities/search_params.dart';
import '../../domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSourceContract _dataSource;

  SearchRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<ProductItemEntity>>> searchProducts(
    SearchParams params,
  ) async {
    return await executeApi<List<ProductItemEntity>>(() async {
      final response = await _dataSource.searchProducts(params);
      if (response.products != null) {
        return response.products!.map((e) => e.toEntity()).toList();
      }
      return [];
    });
  }
}
