import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/register/api/api_client/register_api_client.dart';
import 'package:elevate_flower_app/features/register/api/datasources/register_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/register/data/models/register_request_body.dart';
import 'package:elevate_flower_app/features/register/data/models/register_user_model.dart';
import 'package:elevate_flower_app/features/register/data/models/register_user_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([RegisterApiClient, InternetConnection])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late RegisterRemoteDataSourceImpl dataSourceImpl;
  late MockRegisterApiClient apiClientMock;
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

    apiClientMock = MockRegisterApiClient();
    dataSourceImpl = RegisterRemoteDataSourceImpl(apiClientMock);
  });

  group("test remote data source implementation", () {
    final RegisterRequestBody requestBody = RegisterRequestBody(
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      password: "password",
      passwordConfirmation: "passwordConfirmation",
      phoneNumber: "phoneNumber",
      gender: "gender",
    );
    test("registerUser returns success when API call succeeds", () async {
      final RegisterUserResponseDto response = RegisterUserResponseDto(
        message: "message",
        token: "token",
        user: User(
          firstName: requestBody.firstName,
          lastName: requestBody.lastName,
          email: requestBody.email,
          phone: requestBody.phoneNumber,
          gender: requestBody.gender,
        ),
      );

      when(
        apiClientMock.registerUser(requestBody),
      ).thenAnswer((_) async => response);

      final result = await dataSourceImpl.registerUser(requestBody);
      expect(result, isA<Success<RegisterUserResponseDto>>());
      final successResult = result as Success<RegisterUserResponseDto>;
      expect(successResult.data, response);
      verify(apiClientMock.registerUser(requestBody)).called(1);
    });

    test("registerUser returns error when API call fails", ()async {
      when(
        apiClientMock.registerUser(requestBody),
      ).thenThrow(Exception());
      final result = await dataSourceImpl.registerUser(requestBody);
      expect(result, isA<Error<RegisterUserResponseDto>>());
      final errorResult = result as Error<RegisterUserResponseDto>;
      expect(errorResult.exception, isA<Exception>());
      verify(apiClientMock.registerUser(requestBody)).called(1);
    });
  });
}
