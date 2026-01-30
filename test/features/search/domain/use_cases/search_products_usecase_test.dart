import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/search/domain/entities/search_params.dart';
import 'package:elevate_flower_app/features/search/domain/repositories/search_repository.dart';
import 'package:elevate_flower_app/features/search/domain/use_cases/search_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_products_usecase_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  late SearchProductsUseCase useCase;
  late MockSearchRepository mockRepository;

  setUpAll(() {
    provideDummy<Result<List<ProductItemEntity>>>(
      const Success<List<ProductItemEntity>>(data: []),
    );
  });

  setUp(() {
    mockRepository = MockSearchRepository();
    useCase = SearchProductsUseCase(mockRepository);
  });

  group('SearchProductsUseCase', () {
    const tParams = SearchParams(keyword: 'rose', page: 1, limit: 10);
    final tProducts = [
      const ProductItemEntity(id: '1', name: 'Rose', price: 100.0),
    ];

    test(
      'should return Success with List of products from the repository',
      () async {
        // Arrange
        when(mockRepository.searchProducts(any)).thenAnswer(
          (_) async => Success<List<ProductItemEntity>>(data: tProducts),
        );

        // Act
        final result = await useCase(tParams);

        // Assert
        expect(result, isA<Success<List<ProductItemEntity>>>());
        expect((result as Success).data, equals(tProducts));
        verify(mockRepository.searchProducts(tParams)).called(1);
      },
    );

    test('should return Error from the repository when it fails', () async {
      // Arrange
      final exception = Exception('Error');
      when(mockRepository.searchProducts(any)).thenAnswer(
        (_) async => Error<List<ProductItemEntity>>(exception: exception),
      );

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, isA<Error<List<ProductItemEntity>>>());
      final errorResult = result as Error<List<ProductItemEntity>>;
      expect(errorResult.exception, equals(exception));
      verify(mockRepository.searchProducts(tParams)).called(1);
    });
  });
}
