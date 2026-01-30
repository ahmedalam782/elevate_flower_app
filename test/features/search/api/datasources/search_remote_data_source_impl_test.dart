import 'package:elevate_flower_app/features/search/api/api_client/search_api_client.dart';
import 'package:elevate_flower_app/features/search/api/datasources/search_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/search/data/models/search_response_model.dart';
import 'package:elevate_flower_app/features/search/domain/entities/search_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([SearchApiClient])
void main() {
  late SearchRemoteDataSourceImpl dataSource;
  late MockSearchApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockSearchApiClient();
    dataSource = SearchRemoteDataSourceImpl(mockApiClient);
  });

  group('SearchRemoteDataSourceImpl', () {
    const tParams = SearchParams(keyword: 'rose', page: 1, limit: 10);
    final tResponse = SearchResponseModel(
      products: [],
      metadata: SearchMetadata(currentPage: 1, numberOfPages: 1, limit: 10),
    );

    test(
      'should call searchProducts on apiClient with correct parameters',
      () async {
        // Arrange
        when(
          mockApiClient.searchProducts(any, any, any),
        ).thenAnswer((_) async => tResponse);

        // Act
        final result = await dataSource.searchProducts(tParams);

        // Assert
        expect(result, equals(tResponse));
        verify(mockApiClient.searchProducts('rose', 1, 10)).called(1);
      },
    );

    test(
      'should throw an exception when apiClient.searchProducts fails',
      () async {
        // Arrange
        when(
          mockApiClient.searchProducts(any, any, any),
        ).thenThrow(Exception('API Error'));

        // Act & Assert
        expect(() => dataSource.searchProducts(tParams), throwsException);
      },
    );
  });
}
