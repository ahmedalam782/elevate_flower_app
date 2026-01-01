import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:elevate_flower_app/features/best_seller/api/datasources/best_seller_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/best_seller/data/models/best_seller_model.dart';
import 'package:elevate_flower_app/features/best_seller/data/models/best_seller_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../register/api/datasources/register_remote_data_source_impl_test.mocks.dart';
import 'best_seller_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([BestSellerApiClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late BestSellerRemoteDataSourceImpl _dataSourceImpl;
  late MockBestSellerApiClient _apiClientMock;
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
    _apiClientMock = MockBestSellerApiClient();
    _dataSourceImpl = BestSellerRemoteDataSourceImpl(_apiClientMock);
  });
  group("BestSellerRemoteDataSourceImpl test", () {
    final BestSellerResponseModel responseModel = BestSellerResponseModel(
      message: "success",
      metadata: null,
      bestSellerList: [
        BestSellerModel(
          id: "1",
          title: "name",
          price: 100,
          imgCover: "imageUrl",
        ),
      ],
    );
    test(
      "test getBestSellerProducts returns BestSellerResponseModel on success",
      () async {
        when(
          _apiClientMock.getBestSellerProducts(),
        ).thenAnswer((_) async => responseModel);
        final result = await _dataSourceImpl.getBestSellerProducts();
        expect(result, isA<Success<BestSellerResponseModel>>());
        final success = result as Success<BestSellerResponseModel>;
        expect(success.data, responseModel);
        verify(_apiClientMock.getBestSellerProducts()).called(1);
      },
    );

    test("test getBestSellerProducts returns Failure on failure", () async {
      when(
        _apiClientMock.getBestSellerProducts(),
      ).thenThrow(Exception("error"));
      final result = await _dataSourceImpl.getBestSellerProducts();
      expect(result, isA<Error>());
      final error = result as Error;
      expect(error.exception, isA<Exception>());
      verify(_apiClientMock.getBestSellerProducts()).called(1);
    });
  });
}
