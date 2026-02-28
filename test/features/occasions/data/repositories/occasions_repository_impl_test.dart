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

@GenerateMocks([OccasionsRemoteDataSourceContract])
import 'occasions_repository_impl_test.mocks.dart';

void main() {
  late OccasionsRepositoryImpl occasionsRepositoryImpl;
  late MockOccasionsRemoteDataSourceContract
  mockOccasionsRemoteDataSourceContract;

  setUpAll(() {
    mockOccasionsRemoteDataSourceContract =
        MockOccasionsRemoteDataSourceContract();
    occasionsRepositoryImpl = OccasionsRepositoryImpl(
      mockOccasionsRemoteDataSourceContract,
    );
    provideDummy<Result<OccasionModel>>(
      const Success<OccasionModel>(data: null),
    );
    provideDummy<Result<ProductModel>>(const Success<ProductModel>(data: null));
  });

  group('Occasions Repository Impl Tests', () {
    test('Should get all occasions', () async {
      // Arrange

      when(mockOccasionsRemoteDataSourceContract.getAllOccasions()).thenAnswer(
        (_) async => Success(
          data: OccasionModel(
            occasions: [Occasion(id: '1', name: 'name', image: 'image')],
          ),
        ),
      );

      // Act
      final result = await occasionsRepositoryImpl.getOccasions();

      // Assert
      expect(result, isA<Success<List<OccasionCardEntity>>>());
      final success = result as Success<List<OccasionCardEntity>>;
      expect(success.data, isA<List<OccasionCardEntity>>());
      expect(success.data!.first.id, '1');
      expect(success.data!.first.name, 'name');
      expect(success.data!.first.image, 'image');
      verify(mockOccasionsRemoteDataSourceContract.getAllOccasions()).called(1);
    });

    test("Get all occasions empty list", () async {
      // Arrange
      when(
        mockOccasionsRemoteDataSourceContract.getAllOccasions(),
      ).thenAnswer((_) async => Success(data: OccasionModel(occasions: [])));

      // Act
      final result = await occasionsRepositoryImpl.getOccasions();

      // Assert
      expect(result, isA<Success<List<OccasionCardEntity>>>());
      final success = result as Success<List<OccasionCardEntity>>;
      expect(success.data, isA<List<OccasionCardEntity>>());
      expect(success.data!.isEmpty, true);
      verify(mockOccasionsRemoteDataSourceContract.getAllOccasions()).called(1);
    });

    test("Get all occasions error", () async {
      // Arrange

      when(
        mockOccasionsRemoteDataSourceContract.getAllOccasions(),
      ).thenAnswer((_) async => Error(exception: Exception()));

      // Act
      final result = await occasionsRepositoryImpl.getOccasions();

      // Assert
      expect(result, isA<Error<List<OccasionCardEntity>>>());
      final error = result as Error<List<OccasionCardEntity>>;
      expect(error.exception, isA<Exception>());
      verify(mockOccasionsRemoteDataSourceContract.getAllOccasions()).called(1);
    });

    test("Get occasion flowers", () async {
      // Arrange
      when(
        mockOccasionsRemoteDataSourceContract.getOccasionFlowers(any),
      ).thenAnswer(
        (_) async => Success(
          data: ProductModel(products: [Product(id: '1', price: 1)]),
        ),
      );

      // Act
      final result = await occasionsRepositoryImpl.getOccasionFlowers('1');

      // Assert
      expect(result, isA<Success<List<ProductItemEntity>>>());
      final success = result as Success<List<ProductItemEntity>>;
      expect(success.data, isA<List<ProductItemEntity>>());
      expect(success.data![0].id, '1');
      expect(success.data![0].price, 1);
      verify(
        mockOccasionsRemoteDataSourceContract.getOccasionFlowers('1'),
      ).called(1);
    });

    test("Get occasion flowers empty list", () async {
      // Arrange
      when(
        mockOccasionsRemoteDataSourceContract.getOccasionFlowers(any),
      ).thenAnswer((_) async => Success(data: ProductModel(products: [])));

      // Act
      final result = await occasionsRepositoryImpl.getOccasionFlowers('1');

      // Assert
      expect(result, isA<Success<List<ProductItemEntity>>>());
      final success = result as Success<List<ProductItemEntity>>;
      expect(success.data, isA<List<ProductItemEntity>>());
      expect(success.data!.isEmpty, true);
      verify(
        mockOccasionsRemoteDataSourceContract.getOccasionFlowers('1'),
      ).called(1);
    });

    test("Get occasion flowers error", () async {
      // Arrange

      when(
        mockOccasionsRemoteDataSourceContract.getOccasionFlowers(any),
      ).thenAnswer((_) async => Error(exception: Exception()));

      // Act
      final result = await occasionsRepositoryImpl.getOccasionFlowers('1');

      // Assert
      expect(result, isA<Error<List<ProductItemEntity>>>());
      final error = result as Error<List<ProductItemEntity>>;
      expect(error.exception, isA<Exception>());
      verify(
        mockOccasionsRemoteDataSourceContract.getOccasionFlowers('1'),
      ).called(1);
    });
  });
}
