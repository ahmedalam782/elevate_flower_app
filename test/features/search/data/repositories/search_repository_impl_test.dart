import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/search/data/datasources/search_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/search/data/models/search_product_model.dart';
import 'package:elevate_flower_app/features/search/data/models/search_response_model.dart';
import 'package:elevate_flower_app/features/search/data/repositories/search_repository_impl.dart';
import 'package:elevate_flower_app/features/search/domain/entities/search_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'search_repository_impl_test.mocks.dart';

@GenerateMocks([SearchRemoteDataSourceContract, InternetConnection])
void main() {
  late SearchRepositoryImpl repository;
  late MockSearchRemoteDataSourceContract mockDataSource;
  late MockInternetConnection mockInternetConnection;

  setUp(() async {
    await GetIt.instance.reset();
    mockInternetConnection = MockInternetConnection();

    when(
      mockInternetConnection.hasInternetAccess,
    ).thenAnswer((_) async => true);

    GetIt.instance.registerSingleton<InternetConnection>(
      mockInternetConnection,
    );

    mockDataSource = MockSearchRemoteDataSourceContract();
    repository = SearchRepositoryImpl(mockDataSource);
  });

  group('SearchRepositoryImpl', () {
    const tParams = SearchParams(keyword: 'rose', page: 1, limit: 10);
    final tProductModel = SearchProductModel(
      id: '1',
      title: 'Rose',
      price: 100.0,
      description: 'Desc',
      imgCover: 'img.jpg',
      priceAfterDiscount: 90.0,
    );
    final tResponse = SearchResponseModel(
      products: [tProductModel],
      metadata: SearchMetadata(currentPage: 1, numberOfPages: 1, limit: 10),
    );

    test(
      'should return Success with List of ProductItemEntity when data source returns data',
      () async {
        // Arrange
        when(
          mockDataSource.searchProducts(any),
        ).thenAnswer((_) async => tResponse);

        // Act
        final result = await repository.searchProducts(tParams);

        // Assert
        expect(result, isA<Success<List<ProductItemEntity>>>());
        final successResult = result as Success<List<ProductItemEntity>>;
        expect(successResult.data!.length, 1);
        expect(successResult.data![0].name, 'Rose');
        verify(mockDataSource.searchProducts(tParams)).called(1);
      },
    );

    test(
      'should return Success with empty list when data source returns response with null products',
      () async {
        // Arrange
        when(
          mockDataSource.searchProducts(any),
        ).thenAnswer((_) async => SearchResponseModel(products: null));

        // Act
        final result = await repository.searchProducts(tParams);

        // Assert
        expect(result, isA<Success<List<ProductItemEntity>>>());
        final successResult = result as Success<List<ProductItemEntity>>;
        expect(successResult.data, isEmpty);
      },
    );

    test('should return Error when data source throws an exception', () async {
      // Arrange
      final exception = Exception('Network Error');
      when(mockDataSource.searchProducts(any)).thenThrow(exception);

      // Act
      final result = await repository.searchProducts(tParams);

      // Assert
      expect(result, isA<Error<List<ProductItemEntity>>>());
      final errorResult = result as Error<List<ProductItemEntity>>;
      expect(errorResult.exception, equals(exception));
    });
  });
}
