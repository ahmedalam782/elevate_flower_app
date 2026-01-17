import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/home/api/api_client/home_api_client.dart';
import 'package:elevate_flower_app/features/home/api/datasources/home_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/home/data/models/category_model.dart';
import 'package:elevate_flower_app/features/home/data/models/home_response.dart';
import 'package:elevate_flower_app/features/home/data/models/occasion_model.dart';
import 'package:elevate_flower_app/features/home/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../register/api/datasources/register_remote_data_source_impl_test.mocks.dart';
import 'home_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([HomeApiClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeRemoteDatasourceImpl dataSourceImpl;
  late MockHomeApiClient apiClientMock;
  late MockInternetConnection mockInternetConnection;

  setUp(() async {
    await GetIt.instance.reset();
    configureDependencies();
    mockInternetConnection = MockInternetConnection();
    when(
      mockInternetConnection.hasInternetAccess,
    ).thenAnswer((_) async => true);
    if (GetIt.instance.isRegistered<InternetConnection>()) {
      GetIt.instance.unregister<InternetConnection>();
    }

    // Register your mock
    GetIt.instance.registerSingleton<InternetConnection>(
      mockInternetConnection,
    );
    apiClientMock = MockHomeApiClient();
    dataSourceImpl = HomeRemoteDatasourceImpl(apiClientMock);
  });

  group("HomeRemoteDataSourceImpl test", () {
    final HomeResponse responseModel = HomeResponse(
      message: "success",
      products: [
        ProductModel(
          id: "1",
          title: "Flower Bouquet 1",
          price: 50,
          imgCover: "imageUrl",
        ),
        ProductModel(
          id: "2",
          title: "Flower Bouquet 2",
          price: 100,
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
      occasions: [
        OccasionModel(id: '1', name: 'Occasion 1', image: 'imageUrl'),
      ],
    );

    test("test getHomeData returns HomeResponse on success", () async {
      // Arrange
      when(apiClientMock.getHomeData()).thenAnswer((_) async => responseModel);

      // Act
      final result = await dataSourceImpl.getHomeData();

      // Assert
      expect(result, isA<Success<HomeResponse>>());
      final success = result as Success<HomeResponse>;
      expect(success.data, responseModel);
      verify(apiClientMock.getHomeData()).called(1);
    });

    test("test getHomeData returns Error on exception", () async {
      // Arrange
      const exceptionMessage = "Network error occurred";
      when(apiClientMock.getHomeData()).thenThrow(Exception(exceptionMessage));

      // Act
      final result = await dataSourceImpl.getHomeData();

      // Assert
      expect(result, isA<Error<HomeResponse>>());
      final error = result as Error<HomeResponse>;
      expect(error.exception, isA<Exception>());
      expect(error.exception.toString(), contains(exceptionMessage));
      verify(apiClientMock.getHomeData()).called(1);
    });

    test("test getHomeData returns Error on any thrown error", () async {
      // Arrange
      when(apiClientMock.getHomeData()).thenThrow(const Error());

      // Act
      final result = await dataSourceImpl.getHomeData();

      // Assert
      expect(result, isA<Error<HomeResponse>>());
      final error = result as Error<HomeResponse>;
      expect(error.exception, isA<Exception>());
      verify(apiClientMock.getHomeData()).called(1);
    });

    test("test getHomeData calls API client exactly once", () async {
      // Arrange
      when(apiClientMock.getHomeData()).thenAnswer((_) async => responseModel);

      // Act
      await dataSourceImpl.getHomeData();

      // Assert
      verify(apiClientMock.getHomeData()).called(1);
      verifyNoMoreInteractions(apiClientMock);
    });
  });
}
