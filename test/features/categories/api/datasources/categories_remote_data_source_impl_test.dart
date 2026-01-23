import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/categories/api/api_client/categories_api_client.dart';
import 'package:elevate_flower_app/features/categories/api/datasources/categories_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_model/category_dto.dart';
import 'package:elevate_flower_app/features/categories/data/models/category_model/category_response_model.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/product_dto.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CategoriesApiClient, InternetConnection])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CategoriesRemoteDataSourceImpl dataSourceImpl;
  late MockCategoriesApiClient apiClientMock;
  late MockInternetConnection mockInternetConnection;

  setUp(() async {
    // Mock SharedPreferences to prevent MissingPluginException
    SharedPreferences.setMockInitialValues({});

    await GetIt.instance.reset();

    // Setup mock InternetConnection BEFORE configureDependencies
    mockInternetConnection = MockInternetConnection();
    when(
      mockInternetConnection.hasInternetAccess,
    ).thenAnswer((_) async => true);

    // Register mock InternetConnection first
    GetIt.instance.registerSingleton<InternetConnection>(
      mockInternetConnection,
    );

    // Now run configureDependencies
    configureDependencies();

    apiClientMock = MockCategoriesApiClient();
    dataSourceImpl = CategoriesRemoteDataSourceImpl(apiClient: apiClientMock);
  });

  group("CategoriesRemoteDataSourceImpl test", () {
    group("getAllCategories", () {
      final CategoryResponseModel responseModel = CategoryResponseModel(
        message: "success",
        categories: [CategoryDto(id: '1', name: 'flower')],
      );

      test(
        "test getAllCategories returns CategoryResponseModel on success",
        () async {
          when(
            apiClientMock.getAllCategories(),
          ).thenAnswer((_) async => responseModel);

          final result = await dataSourceImpl.getAllCategories();

          expect(result, isA<Success<CategoryResponseModel>>());
          final success = result as Success<CategoryResponseModel>;
          expect(success.data, responseModel);
          verify(apiClientMock.getAllCategories()).called(1);
        },
      );

      test("test getAllCategories returns Error on failure", () async {
        when(apiClientMock.getAllCategories()).thenThrow(Exception("error"));

        final result = await dataSourceImpl.getAllCategories();

        expect(result, isA<Error>());
        final error = result as Error;
        expect(error.exception, isA<Exception>());
        verify(apiClientMock.getAllCategories()).called(1);
      });
    });

    group("getAllProducts", () {
      final ProductsResponseModels responseModel = ProductsResponseModels(
        message: "success",
        products: [
          ProductDto(id: "1", title: "flower", imgCover: "image", price: 100),
        ],
      );

      test(
        "test getAllProducts with categoryId returns ProductsResponseModels on success",
        () async {
          const categoryId = "123";
          when(
            apiClientMock.getAllProducts(categoryId),
          ).thenAnswer((_) async => responseModel);

          final result = await dataSourceImpl.getAllProducts(categoryId);

          expect(result, isA<Success<ProductsResponseModels>>());
          final success = result as Success<ProductsResponseModels>;
          expect(success.data, responseModel);
          verify(apiClientMock.getAllProducts(categoryId)).called(1);
        },
      );

      test(
        "test getAllProducts with null categoryId returns ProductsResponseModels on success",
        () async {
          when(
            apiClientMock.getAllProducts(null),
          ).thenAnswer((_) async => responseModel);

          final result = await dataSourceImpl.getAllProducts(null);

          expect(result, isA<Success<ProductsResponseModels>>());
          final success = result as Success<ProductsResponseModels>;
          expect(success.data, responseModel);
          verify(apiClientMock.getAllProducts(null)).called(1);
        },
      );

      test(
        "test getAllProducts with categoryId returns Error on failure",
        () async {
          const categoryId = "123";
          when(
            apiClientMock.getAllProducts(categoryId),
          ).thenThrow(Exception("error"));

          final result = await dataSourceImpl.getAllProducts(categoryId);

          expect(result, isA<Error>());
          final error = result as Error;
          expect(error.exception, isA<Exception>());
          verify(apiClientMock.getAllProducts(categoryId)).called(1);
        },
      );

      test(
        "test getAllProducts with null categoryId returns Error on failure",
        () async {
          when(
            apiClientMock.getAllProducts(null),
          ).thenThrow(Exception("error"));

          final result = await dataSourceImpl.getAllProducts(null);

          expect(result, isA<Error>());
          final error = result as Error;
          expect(error.exception, isA<Exception>());
          verify(apiClientMock.getAllProducts(null)).called(1);
        },
      );
    });
  });
}
