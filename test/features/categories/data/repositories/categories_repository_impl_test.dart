import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/categories/data/datasources/categories_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_model/category_dto.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_model/category_response_model.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/product_dto.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:elevate_flower_app/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_repository_impl_test.mocks.dart';

@GenerateMocks([CategoriesRemoteDataSourceContract])
void main() {
  late CategoriesRepositoryImpl repository;
  late MockCategoriesRemoteDataSourceContract mockRemoteDataSource;

  setUpAll(() {
    provideDummy<Result<CategoryResponseModel>>(
      const Success<CategoryResponseModel>(data: null),
    );
    provideDummy<Result<ProductsResponseModels>>(
      const Success<ProductsResponseModels>(data: null),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockCategoriesRemoteDataSourceContract();
    repository = CategoriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group("CategoriesRepositoryImpl test", () {
    group("getAllCategories", () {
      test(
        "test getAllCategories returns Success with list of CategoryEntity on success",
        () async {
          // Arrange
          final responseModel = CategoryResponseModel(
            message: "success",
            categories: [],
          );

          when(
            mockRemoteDataSource.getAllCategories(),
          ).thenAnswer((_) async => Success(data: responseModel));

          // Act
          final result = await repository.getAllCategories();

          // Assert
          expect(result, isA<Success<List<CategoryEntity>>>());
          final success = result as Success<List<CategoryEntity>>;
          expect(success.data, isA<List<CategoryEntity>>());
          verify(mockRemoteDataSource.getAllCategories()).called(1);
        },
      );

      test(
        "test getAllCategories returns Success with categories data",
        () async {
          // Arrange
          final responseModel = CategoryResponseModel(
            message: "success",
            categories: [
              CategoryDto(id: '1', name: 'Roses'),
              CategoryDto(id: '2', name: 'Tulips'),
            ],
          );

          when(
            mockRemoteDataSource.getAllCategories(),
          ).thenAnswer((_) async => Success(data: responseModel));

          // Act
          final result = await repository.getAllCategories();

          // Assert
          expect(result, isA<Success<List<CategoryEntity>>>());
          final success = result as Success<List<CategoryEntity>>;
          expect(success.data, isNotNull);
          expect(success.data!, hasLength(2));
          expect(success.data!.first.id, '1');
          expect(success.data!.first.name, 'Roses');
          expect(success.data![1].id, '2');
          expect(success.data![1].name, 'Tulips');
          verify(mockRemoteDataSource.getAllCategories()).called(1);
        },
      );

      test(
        "test getAllCategories returns empty list when response data is null",
        () async {
          // Arrange
          when(
            mockRemoteDataSource.getAllCategories(),
          ).thenAnswer((_) async => const Success(data: null));

          // Act
          final result = await repository.getAllCategories();

          // Assert
          expect(result, isA<Success<List<CategoryEntity>>>());
          final success = result as Success<List<CategoryEntity>>;
          expect(success.data, isEmpty);
          verify(mockRemoteDataSource.getAllCategories()).called(1);
        },
      );

      test("test getAllCategories returns Error on failure", () async {
        // Arrange
        final exception = Exception("Failed to fetch categories");

        when(
          mockRemoteDataSource.getAllCategories(),
        ).thenAnswer((_) async => Error(exception: exception));

        // Act
        final result = await repository.getAllCategories();

        // Assert
        expect(result, isA<Error<List<CategoryEntity>>>());
        final error = result as Error<List<CategoryEntity>>;
        expect(error.exception, exception);
        verify(mockRemoteDataSource.getAllCategories()).called(1);
      });
    });

    group("getAllproducts", () {
      test(
        "test getAllproducts with categoryId returns Success with list of ProductEntity on success",
        () async {
          // Arrange
          const categoryId = "123";
          final responseModel = ProductsResponseModels(
            message: "success",
            products: [
              ProductDto(
                id: "1",
                title: "flower",
                imgCover: "image",
                price: 100,
              ),
            ],
          );

          when(
            mockRemoteDataSource.getAllProducts(categoryId),
          ).thenAnswer((_) async => Success(data: responseModel));

          // Act
          final result = await repository.getAllproducts(categoryId);

          // Assert
          expect(result, isA<Success<List<ProductEntity>>>());
          final success = result as Success<List<ProductEntity>>;
          expect(success.data, isA<List<ProductEntity>>());
          verify(mockRemoteDataSource.getAllProducts(categoryId)).called(1);
        },
      );

      test(
        "test getAllproducts correctly maps ProductDto to ProductEntity",
        () async {
          // Arrange
          const categoryId = "123";
          final responseModel = ProductsResponseModels(
            message: "success",
            products: [
              ProductDto(
                id: "1",
                title: "Red Rose",
                imgCover: "rose.jpg",
                price: 150,
              ),
            ],
          );

          when(
            mockRemoteDataSource.getAllProducts(categoryId),
          ).thenAnswer((_) async => Success(data: responseModel));

          // Act
          final result = await repository.getAllproducts(categoryId);

          // Assert
          expect(result, isA<Success<List<ProductEntity>>>());
          final success = result as Success<List<ProductEntity>>;
          expect(success.data, isNotNull);
          expect(success.data!, hasLength(1));

          final product = success.data!.first;
          expect(product.id, "1");
          expect(product.title, "Red Rose");
          expect(product.imgCover, "rose.jpg");
          expect(product.price, 150);

          verify(mockRemoteDataSource.getAllProducts(categoryId)).called(1);
        },
      );

      test(
        "test getAllproducts with null categoryId returns Success with list of ProductEntity on success",
        () async {
          // Arrange
          final responseModel = ProductsResponseModels(
            message: "success",
            products: [
              ProductDto(
                id: "1",
                title: "flower",
                imgCover: "image",
                price: 100,
              ),
            ],
          );

          when(
            mockRemoteDataSource.getAllProducts(null),
          ).thenAnswer((_) async => Success(data: responseModel));

          // Act
          final result = await repository.getAllproducts(null);

          // Assert
          expect(result, isA<Success<List<ProductEntity>>>());
          final success = result as Success<List<ProductEntity>>;
          expect(success.data, isA<List<ProductEntity>>());
          verify(mockRemoteDataSource.getAllProducts(null)).called(1);
        },
      );

      test(
        "test getAllproducts returns empty list when products list is empty",
        () async {
          // Arrange
          const categoryId = "123";
          final responseModel = ProductsResponseModels(
            message: "success",
            products: [],
          );

          when(
            mockRemoteDataSource.getAllProducts(categoryId),
          ).thenAnswer((_) async => Success(data: responseModel));

          // Act
          final result = await repository.getAllproducts(categoryId);

          // Assert
          expect(result, isA<Success<List<ProductEntity>>>());
          final success = result as Success<List<ProductEntity>>;
          expect(success.data, isEmpty);
          verify(mockRemoteDataSource.getAllProducts(categoryId)).called(1);
        },
      );

      test(
        "test getAllproducts returns empty list when response data is null",
        () async {
          // Arrange
          const categoryId = "123";

          when(
            mockRemoteDataSource.getAllProducts(categoryId),
          ).thenAnswer((_) async => const Success(data: null));

          // Act
          final result = await repository.getAllproducts(categoryId);

          // Assert
          expect(result, isA<Success<List<ProductEntity>>>());
          final success = result as Success<List<ProductEntity>>;
          expect(success.data, isEmpty);
          verify(mockRemoteDataSource.getAllProducts(categoryId)).called(1);
        },
      );

      test(
        "test getAllproducts with categoryId returns Error on failure",
        () async {
          // Arrange
          const categoryId = "123";
          final exception = Exception("Failed to fetch products");

          when(
            mockRemoteDataSource.getAllProducts(categoryId),
          ).thenAnswer((_) async => Error(exception: exception));

          // Act
          final result = await repository.getAllproducts(categoryId);

          // Assert
          expect(result, isA<Error<List<ProductEntity>>>());
          final error = result as Error<List<ProductEntity>>;
          expect(error.exception, exception);
          verify(mockRemoteDataSource.getAllProducts(categoryId)).called(1);
        },
      );

      test(
        "test getAllproducts with null categoryId returns Error on failure",
        () async {
          // Arrange
          final exception = Exception("Network error");

          when(
            mockRemoteDataSource.getAllProducts(null),
          ).thenAnswer((_) async => Error(exception: exception));

          // Act
          final result = await repository.getAllproducts(null);

          // Assert
          expect(result, isA<Error<List<ProductEntity>>>());
          final error = result as Error<List<ProductEntity>>;
          expect(error.exception, exception);
          verify(mockRemoteDataSource.getAllProducts(null)).called(1);
        },
      );
    });
  });
}