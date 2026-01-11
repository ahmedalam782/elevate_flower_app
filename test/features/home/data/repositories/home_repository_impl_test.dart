import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/home/data/datasources/home_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/home/data/models/category_model.dart';
import 'package:elevate_flower_app/features/home/data/models/home_response.dart';
import 'package:elevate_flower_app/features/home/data/models/occasion_model.dart';
import 'package:elevate_flower_app/features/home/data/models/product_model.dart';
import 'package:elevate_flower_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:elevate_flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSourceContract])
void main() {
  late HomeRepoImpl homeRepository;
  late MockHomeRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSourceContract();
    homeRepository = HomeRepoImpl(mockRemoteDataSource);
  });

  group("HomeRepositoryImpl test", () {
    // Dummy data for testing
    final dummyHomeResponse = HomeResponse(
      message: "success",
      products: [
        ProductModel(
          id: "1",
          title: "Product 1",
          price: 100,
          imgCover: "image1",
        ),
      ],
      categories: [
        CategoryModel(id: "1", name: "Category 1", image: "cat_image"),
      ],
      bestSeller: [
        ProductModel(
          id: "1",
          title: "Best 1",
          price: 200,
          imgCover: "best_image",
        ),
      ],
      occasions: [
        OccasionModel(id: "1", name: "Occasion 1", image: "occ_image"),
      ],
    );

    test("test getHomeData returns HomeEntity on success", () async {
      // Arrange
      provideDummy<Result<HomeResponse>>(const Success<HomeResponse>());
      when(
        mockRemoteDataSource.getHomeData(),
      ).thenAnswer((_) async => Success(data: dummyHomeResponse));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result, isA<Success<HomeEntity>>());
      final success = result as Success<HomeEntity>;
      expect(success.data, isA<HomeEntity>());

      // Verify the entity has correct structure
      expect(success.data?.products, isA<List>());
      expect(success.data?.categories, isA<List>());
      expect(success.data?.bestSeller, isA<List>());
      expect(success.data?.occasions, isA<List>());

      // Verify data source was called
      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test(
      "test getHomeData maps data correctly from response to entity",
      () async {
        // Arrange
        provideDummy<Result<HomeResponse>>(const Success<HomeResponse>());
        when(
          mockRemoteDataSource.getHomeData(),
        ).thenAnswer((_) async => Success(data: dummyHomeResponse));

        // Act
        final result = await homeRepository.getHomeData();

        // Assert
        expect(result, isA<Success<HomeEntity>>());
        final success = result as Success<HomeEntity>;

        // Verify mapping happened correctly
        expect(
          success.data?.products.length,
          dummyHomeResponse.products.length,
        );
        expect(
          success.data?.categories.length,
          dummyHomeResponse.categories.length,
        );
        expect(
          success.data?.bestSeller.length,
          dummyHomeResponse.bestSeller.length,
        );
        expect(
          success.data?.occasions.length,
          dummyHomeResponse.occasions.length,
        );

        verify(mockRemoteDataSource.getHomeData()).called(1);
      },
    );

    test("test getHomeData returns Error when data source fails", () async {
      // Arrange
      final exception = Exception("Network error");
      provideDummy<Result<HomeResponse>>(Error(exception: exception));
      when(
        mockRemoteDataSource.getHomeData(),
      ).thenAnswer((_) async => Error(exception: exception));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result, isA<Error<HomeEntity>>());
      final error = result as Error<HomeEntity>;
      expect(error.exception, isA<Exception>());
      expect(error.exception.toString(), contains("Network error"));

      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test("test getHomeData handles null products list", () async {
      // Arrange
      final responseWithNullProducts = HomeResponse(
        message: "success",
        products: [],
        categories: [
          CategoryModel(id: '1', name: 'Category 1', image: 'imageUrl'),
        ],
        bestSeller: [
          ProductModel(
            id: "2",
            title: "Flower Bouquet 2",
            price: 100,
            imgCover: "imageUrl",
          ),
        ],
        occasions: [
          OccasionModel(id: '1', name: 'Occasion 1', image: 'imageUrl'),
        ],
      );
      provideDummy<Result<HomeResponse>>(const Success<HomeResponse>());
      when(
        mockRemoteDataSource.getHomeData(),
      ).thenAnswer((_) async => Success(data: responseWithNullProducts));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result, isA<Success<HomeEntity>>());
      final success = result as Success<HomeEntity>;
      expect(success.data?.products, isEmpty);

      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test("test getHomeData handles null categories list", () async {
      // Arrange
      final responseWithNullCategories = HomeResponse(
        message: "success",
        products: [
          ProductModel(
            id: "1",
            title: "Flower Bouquet 1",
            price: 50,
            imgCover: "imageUrl",
          ),
        ],
        categories: [],
        bestSeller: [
          ProductModel(
            id: "2",
            title: "Flower Bouquet 2",
            price: 100,
            imgCover: "imageUrl",
          ),
        ],
        occasions: [
          OccasionModel(id: '1', name: 'Occasion 1', image: 'imageUrl'),
        ],
      );
      provideDummy<Result<HomeResponse>>(const Success<HomeResponse>());
      when(
        mockRemoteDataSource.getHomeData(),
      ).thenAnswer((_) async => Success(data: responseWithNullCategories));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result, isA<Success<HomeEntity>>());
      final success = result as Success<HomeEntity>;
      expect(success.data?.categories, isEmpty);

      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test("test getHomeData handles null bestSeller list", () async {
      // Arrange
      final responseWithNullBestSeller = HomeResponse(
        message: "success",
        products: [
          ProductModel(
            id: "1",
            title: "Flower Bouquet 1",
            price: 50,
            imgCover: "imageUrl",
          ),
        ],
        categories: [
          CategoryModel(id: '1', name: 'Category 1', image: 'imageUrl'),
        ],
        bestSeller: [],
        occasions: [
          OccasionModel(id: '1', name: 'Occasion 1', image: 'imageUrl'),
        ],
      );
      provideDummy<Result<HomeResponse>>(const Success<HomeResponse>());
      when(
        mockRemoteDataSource.getHomeData(),
      ).thenAnswer((_) async => Success(data: responseWithNullBestSeller));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result, isA<Success<HomeEntity>>());
      final success = result as Success<HomeEntity>;
      expect(success.data?.bestSeller, isEmpty);

      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test("test getHomeData handles null occasions list", () async {
      // Arrange
      final responseWithNullOccasions = HomeResponse(
        message: "success",
        products: [
          ProductModel(
            id: "1",
            title: "Flower Bouquet 1",
            price: 50,
            imgCover: "imageUrl",
          ),
        ],
        categories: [
          CategoryModel(id: '1', name: 'Category 1', image: 'imageUrl'),
        ],
        bestSeller: [
          ProductModel(
            id: "2",
            title: "Flower Bouquet 2",
            price: 100,
            imgCover: "imageUrl",
          ),
        ],
        occasions: [],
      );
      provideDummy<Result<HomeResponse>>(const Success<HomeResponse>());
      when(
        mockRemoteDataSource.getHomeData(),
      ).thenAnswer((_) async => Success(data: responseWithNullOccasions));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result, isA<Success<HomeEntity>>());
      final success = result as Success<HomeEntity>;
      expect(success.data?.occasions, isEmpty);

      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test("test getHomeData calls remote data source exactly once", () async {
      // Arrange
      provideDummy<Result<HomeResponse>>(const Success<HomeResponse>());
      when(
        mockRemoteDataSource.getHomeData(),
      ).thenAnswer((_) async => Success(data: dummyHomeResponse));

      // Act
      await homeRepository.getHomeData();

      // Assert
      verify(mockRemoteDataSource.getHomeData()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
