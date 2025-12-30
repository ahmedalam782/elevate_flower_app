import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/occasions/data/datasources/occasions_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/occasions/data/models/occasions_model.dart';
import 'package:elevate_flower_app/features/occasions/data/models/product_model.dart';
import 'package:elevate_flower_app/features/occasions/data/repositories/occasions_repository_impl.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/occasion_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'occasions_repository_impl_test.mocks.dart';

@GenerateMocks([OccasionsRemoteDataSourceContract])
void main() {
  late OccasionsRepositoryImpl repository;
  late MockOccasionsRemoteDataSourceContract mockDataSource;

  setUp(() {
    mockDataSource = MockOccasionsRemoteDataSourceContract();
    repository = OccasionsRepositoryImpl(mockDataSource);
  });

  setUpAll(() {
    provideDummy<Result<OccasionModel>>(
      Success<OccasionModel>(data: OccasionModel()),
    );
    provideDummy<Result<ProductModel>>(
      Success<ProductModel>(data: ProductModel()),
    );
  });

  group('OccasionsRepositoryImpl', () {
    group('getOccasions', () {
      test(
        'should return Success with list of OccasionCardEntity when data source succeeds',
        () async {
          // Arrange
          final occasionModel = OccasionModel(
            message: 'Success',
            occasions: [
              Occasion(
                id: '1',
                name: 'Birthday',
                image: 'birthday.jpg',
                productsCount: 10,
              ),
              Occasion(
                id: '2',
                name: 'Wedding',
                image: 'wedding.jpg',
                productsCount: 5,
              ),
            ],
          );

          when(
            mockDataSource.getAllOccasions(),
          ).thenAnswer((_) async => Success(data: occasionModel));

          // Act
          final result = await repository.getOccasions();

          // Assert
          expect(result, isA<Success<List<OccasionCardEntity>>>());
          final successResult = result as Success<List<OccasionCardEntity>>;
          expect(successResult.data, isNotNull);
          expect(successResult.data!.length, 2);

          expect(successResult.data![0].id, '1');
          expect(successResult.data![0].name, 'Birthday');
          expect(successResult.data![0].image, 'birthday.jpg');
          expect(successResult.data![0].productsCount, 10);

          expect(successResult.data![1].id, '2');
          expect(successResult.data![1].name, 'Wedding');
          expect(successResult.data![1].image, 'wedding.jpg');
          expect(successResult.data![1].productsCount, 5);

          verify(mockDataSource.getAllOccasions()).called(1);
        },
      );

      test(
        'should return Success with empty list when data source returns null occasions',
        () async {
          // Arrange
          final occasionModel = OccasionModel(
            message: 'Success',
            occasions: null,
          );

          when(
            mockDataSource.getAllOccasions(),
          ).thenAnswer((_) async => Success(data: occasionModel));

          // Act
          final result = await repository.getOccasions();

          // Assert
          expect(result, isA<Success<List<OccasionCardEntity>>>());
          final successResult = result as Success<List<OccasionCardEntity>>;
          expect(successResult.data, isNotNull);
          expect(successResult.data!.length, 0);

          verify(mockDataSource.getAllOccasions()).called(1);
        },
      );

      test('should return Error when data source fails', () async {
        // Arrange
        final exception = Exception('Network error');
        when(
          mockDataSource.getAllOccasions(),
        ).thenAnswer((_) async => Error(exception: exception));

        // Act
        final result = await repository.getOccasions();

        // Assert
        expect(result, isA<Error<List<OccasionCardEntity>>>());
        final errorResult = result as Error<List<OccasionCardEntity>>;
        expect(errorResult.exception, exception);

        verify(mockDataSource.getAllOccasions()).called(1);
      });
    });

    group('getOccasionFlowers', () {
      const occasionId = 'test-occasion-id';

      test(
        'should return Success with list of ProductItemEntity when data source succeeds',
        () async {
          // Arrange
          final productModel = ProductModel(
            message: 'Success',
            products: [
              Product(
                id: '1',
                title: 'Rose Bouquet',
                description: 'Beautiful red roses',
                imgCover: 'rose.jpg',
                price: 5000,
                priceAfterDiscount: 4500,
              ),
              Product(
                id: '2',
                title: 'Tulip Bouquet',
                description: 'Colorful tulips',
                imgCover: 'tulip.jpg',
                price: 4000,
                priceAfterDiscount: 3800,
              ),
            ],
          );

          when(
            mockDataSource.getOccasionFlowers(occasionId),
          ).thenAnswer((_) async => Success(data: productModel));

          // Act
          final result = await repository.getOccasionFlowers(occasionId);

          // Assert
          expect(result, isA<Success<List<ProductItemEntity>>>());
          final successResult = result as Success<List<ProductItemEntity>>;
          expect(successResult.data, isNotNull);
          expect(successResult.data!.length, 2);

          expect(successResult.data![0].id, '1');
          expect(successResult.data![0].name, 'Rose Bouquet');
          expect(successResult.data![0].description, 'Beautiful red roses');
          expect(successResult.data![0].imageUrl, 'rose.jpg');
          expect(successResult.data![0].price, 5000.0);
          expect(successResult.data![0].priceAfterDiscount, 4500.0);

          expect(successResult.data![1].id, '2');
          expect(successResult.data![1].name, 'Tulip Bouquet');
          expect(successResult.data![1].description, 'Colorful tulips');
          expect(successResult.data![1].imageUrl, 'tulip.jpg');
          expect(successResult.data![1].price, 4000.0);
          expect(successResult.data![1].priceAfterDiscount, 3800.0);

          verify(mockDataSource.getOccasionFlowers(occasionId)).called(1);
        },
      );

      test(
        'should return Success with empty list when data source returns null products',
        () async {
          // Arrange
          final productModel = ProductModel(message: 'Success', products: null);

          when(
            mockDataSource.getOccasionFlowers(occasionId),
          ).thenAnswer((_) async => Success(data: productModel));

          // Act
          final result = await repository.getOccasionFlowers(occasionId);

          // Assert
          expect(result, isA<Success<List<ProductItemEntity>>>());
          final successResult = result as Success<List<ProductItemEntity>>;
          expect(successResult.data, isNotNull);
          expect(successResult.data!.length, 0);

          verify(mockDataSource.getOccasionFlowers(occasionId)).called(1);
        },
      );

      test('should return Error when data source fails', () async {
        // Arrange
        final exception = Exception('API error');
        when(
          mockDataSource.getOccasionFlowers(occasionId),
        ).thenAnswer((_) async => Error(exception: exception));

        // Act
        final result = await repository.getOccasionFlowers(occasionId);

        // Assert
        expect(result, isA<Error<List<ProductItemEntity>>>());
        final errorResult = result as Error<List<ProductItemEntity>>;
        expect(errorResult.exception, exception);

        verify(mockDataSource.getOccasionFlowers(occasionId)).called(1);
      });
    });
  });
}
