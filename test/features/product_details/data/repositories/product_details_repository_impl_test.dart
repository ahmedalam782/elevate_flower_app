import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/product_details/data/datasources/product_details_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/product_details/data/models/specefic_product_response/specefic_product_response.dart';
import 'package:elevate_flower_app/features/product_details/data/repositories/product_details_repository_impl.dart';
import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';

class MockProductDetailsRemoteDataSource extends Mock
    implements ProductDetailsRemoteDataSourceContract {}
void main() {
  late MockProductDetailsRemoteDataSource mockProductDetailsRemoteDataSource;
  late ProductDetailsRepositoryImpl repository;

  setUp(() {
    mockProductDetailsRemoteDataSource = MockProductDetailsRemoteDataSource();
    repository = ProductDetailsRepositoryImpl(
      productDetailsRemoteDataSourceContract:
          mockProductDetailsRemoteDataSource,
    );
  });

  group('ProductDetailsRepositoryImpl', () {
    const String testProductId = '123';
    final testProductDto = SpeceficProductDto(
      id: testProductId,
      title: 'Rose Bouquet',
      description: 'Beautiful red roses',
      price: 100,
      priceAfterDiscount: 80,
      images: ['image1.jpg', 'image2.jpg'],
      imgCover: 'cover.jpg',
    );

    final _ = SpeceficProductEntity(
      productId: testProductId,
      productName: 'Rose Bouquet',
      productDescription: 'Beautiful red roses',
      productPrice: 100,
      productPriceAfterDiscount: 80,
      productImages: ['image1.jpg', 'image2.jpg'],
    );

    group('getSpeceficProduct', () {
      test(
        'should return SpeceficProductEntity when data source call is successful',
        () async {
          // Arrange
          final testResponse = SpeceficProductResponse(
            message: 'Success',
            product: testProductDto,
          );

          when(
            () => mockProductDetailsRemoteDataSource.getSpeceficProduct(
              testProductId,
            ),
          ).thenAnswer(
            (_) async => Success<SpeceficProductResponse>(data: testResponse),
          );

          // Act
          final result = await repository.getSpeceficProduct(testProductId);

          // Assert
          expect(result, isA<Success<SpeceficProductEntity>>());
          final successResult = result as Success<SpeceficProductEntity>;
          expect(successResult.data?.productId, equals(testProductId));
          expect(successResult.data?.productName, equals('Rose Bouquet'));
          expect(
            successResult.data?.productDescription,
            equals('Beautiful red roses'),
          );
          expect(successResult.data?.productPrice, equals(100));
          expect(successResult.data?.productPriceAfterDiscount, equals(80));
          expect(
            successResult.data?.productImages,
            equals(['image1.jpg', 'image2.jpg']),
          );

          verify(
            () => mockProductDetailsRemoteDataSource.getSpeceficProduct(
              testProductId,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockProductDetailsRemoteDataSource);
        },
      );

      test('should return Error when data source call fails', () async {
        // Arrange
        final exception = Exception('Network error');
        when(
          () => mockProductDetailsRemoteDataSource.getSpeceficProduct(
            testProductId,
          ),
        ).thenAnswer(
          (_) async => Error<SpeceficProductResponse>(exception: exception),
        );

        // Act
        final result = await repository.getSpeceficProduct(testProductId);

        // Assert
        expect(result, isA<Error<SpeceficProductEntity>>());
        final errorResult = result as Error<SpeceficProductEntity>;
        expect(errorResult.exception, equals(exception));

        verify(
          () => mockProductDetailsRemoteDataSource.getSpeceficProduct(
            testProductId,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockProductDetailsRemoteDataSource);
      });

      test('should handle null product data gracefully', () async {
        // Arrange
        final testResponse = SpeceficProductResponse(
          message: 'Success',
          product: null,
        );

        when(
          () => mockProductDetailsRemoteDataSource.getSpeceficProduct(
            testProductId,
          ),
        ).thenAnswer(
          (_) async => Success<SpeceficProductResponse>(data: testResponse),
        );

        // Act
        final result = await repository.getSpeceficProduct(testProductId);

        // Assert
        expect(result, isA<Success<SpeceficProductEntity>>());
        final successResult = result as Success<SpeceficProductEntity>;
        expect(successResult.data, isNull);

        verify(
          () => mockProductDetailsRemoteDataSource.getSpeceficProduct(
            testProductId,
          ),
        ).called(1);
      });

      test(
        'should map all product fields correctly from DTO to entity',
        () async {
          // Arrange
          final detailedProductDto = SpeceficProductDto(
            id: '456',
            title: 'Premium Tulips',
            description: 'Elegant yellow tulips',
            price: 150,
            priceAfterDiscount: 120,
            images: ['tulip1.jpg', 'tulip2.jpg', 'tulip3.jpg'],
            imgCover: 'tulip_cover.jpg',
            slug: 'premium-tulips',
            quantity: 50,
            category: 'flowers',
            occasion: 'birthday',
          );

          final testResponse = SpeceficProductResponse(
            message: 'Success',
            product: detailedProductDto,
          );

          when(
            () => mockProductDetailsRemoteDataSource.getSpeceficProduct('456'),
          ).thenAnswer(
            (_) async => Success<SpeceficProductResponse>(data: testResponse),
          );

          // Act
          final result = await repository.getSpeceficProduct('456');

          // Assert
          expect(result, isA<Success<SpeceficProductEntity>>());
          final successResult = result as Success<SpeceficProductEntity>;
          expect(successResult.data?.productId, equals('456'));
          expect(successResult.data?.productName, equals('Premium Tulips'));
          expect(
            successResult.data?.productDescription,
            equals('Elegant yellow tulips'),
          );
          expect(successResult.data?.productPrice, equals(150));
          expect(successResult.data?.productPriceAfterDiscount, equals(120));
          expect(
            successResult.data?.productImages,
            equals(['tulip1.jpg', 'tulip2.jpg', 'tulip3.jpg']),
          );
        },
      );

      test(
        'should handle missing optional fields with default values',
        () async {
          // Arrange
          final minimalProductDto = SpeceficProductDto(
            id: '789',
            title: null,
            description: null,
            price: null,
            priceAfterDiscount: null,
            images: null,
          );

          final testResponse = SpeceficProductResponse(
            message: 'Success',
            product: minimalProductDto,
          );

          when(
            () => mockProductDetailsRemoteDataSource.getSpeceficProduct('789'),
          ).thenAnswer(
            (_) async => Success<SpeceficProductResponse>(data: testResponse),
          );

          // Act
          final result = await repository.getSpeceficProduct('789');

          // Assert
          expect(result, isA<Success<SpeceficProductEntity>>());
          final successResult = result as Success<SpeceficProductEntity>;
          expect(successResult.data?.productId, equals('789'));
          expect(successResult.data?.productName, equals(''));
          expect(successResult.data?.productDescription, equals(''));
          expect(successResult.data?.productPrice, equals(0));
          expect(successResult.data?.productPriceAfterDiscount, equals(0));
          expect(successResult.data?.productImages, equals([]));
        },
      );

      test('should pass the correct product ID to the data source', () async {
        // Arrange
        when(
          () => mockProductDetailsRemoteDataSource.getSpeceficProduct(any()),
        ).thenAnswer(
          (_) async => Success<SpeceficProductResponse>(
            data: SpeceficProductResponse(product: testProductDto),
          ),
        );

        // Act
        await repository.getSpeceficProduct(testProductId);

        // Assert
        verify(
          () => mockProductDetailsRemoteDataSource.getSpeceficProduct(
            testProductId,
          ),
        ).called(1);
      });

      test(
        'should return Error with correct exception type on network failure',
        () async {
          // Arrange
          final networkException = Exception('No internet connection');
          when(
            () => mockProductDetailsRemoteDataSource.getSpeceficProduct(
              testProductId,
            ),
          ).thenAnswer(
            (_) async =>
                Error<SpeceficProductResponse>(exception: networkException),
          );

          // Act
          final result = await repository.getSpeceficProduct(testProductId);

          // Assert
          expect(result, isA<Error<SpeceficProductEntity>>());
          final errorResult = result as Error<SpeceficProductEntity>;
          expect(
            errorResult.exception.toString(),
            contains('No internet connection'),
          );
        },
      );
    });
  });
}
