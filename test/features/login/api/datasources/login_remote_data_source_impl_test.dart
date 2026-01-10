import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/errors/failures.dart';
import 'package:elevate_flower_app/features/login/api/api_client/login_api_client.dart';
import 'package:elevate_flower_app/features/login/api/datasources/login_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/login/data/models/login_request_model.dart';
import 'package:elevate_flower_app/features/login/data/models/login_response_model.dart';
import 'package:elevate_flower_app/features/login/data/models/login_user_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([LoginApiClient, InternetConnection])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LoginRemoteDataSourceImpl dataSourceImpl;
  late MockLoginApiClient apiClientMock;
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

    GetIt.instance.registerSingleton<InternetConnection>(
      mockInternetConnection,
    );

    apiClientMock = MockLoginApiClient();
    dataSourceImpl = LoginRemoteDataSourceImpl(apiClient: apiClientMock);
  });

  group("test login remote data source implementation", () {
    final LoginRequestModel requestBody = LoginRequestModel(
      email: "test@example.com",
      password: "password123",
    );

    const bool rememberMe = true;

    test("loginUser returns success when API call succeeds", () async {
      // Arrange
      final LoginResponseModel response = LoginResponseModel(
        message: "Login successful",
        token: "test_token_123",
        user: LoginUserDto(
          id: "user_id_123",
          firstName: "Test",
          lastName: "User",
          email: requestBody.email,
          gender: "male",
          phone: "1234567890",
          photo: "photo_url",
          role: "user",
          wishlist: [],
          addresses: [],
          createdAt: "2024-01-01T00:00:00.000Z",
        ),
      );

      when(apiClientMock.login(requestBody)).thenAnswer((_) async => response);

      // Act
      final result = await dataSourceImpl.loginUser(
        body: requestBody,
        rememberMe: rememberMe,
      );

      // Assert
      expect(result, isA<Success<LoginResponseModel>>());
      final successResult = result as Success<LoginResponseModel>;
      expect(successResult.data, response);
      expect(successResult.data?.token, "test_token_123");
      expect(successResult.data?.message, "Login successful");
      expect(successResult.data?.user.email, requestBody.email);
      verify(apiClientMock.login(requestBody)).called(1);
    });

    test(
      "loginUser returns error when API call fails with DioException (Invalid email/password)",
      () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/login'),
          response: Response(
            requestOptions: RequestOptions(path: '/login'),
            statusCode: 401,
            data: {'message': 'Invalid credentials'},
          ),
          type: DioExceptionType.badResponse,
        );

        when(apiClientMock.login(requestBody)).thenThrow(dioException);

        // Act
        final result = await dataSourceImpl.loginUser(
          body: requestBody,
          rememberMe: rememberMe,
        );

        // Assert
        expect(result, isA<Error<LoginResponseModel>>());
        final errorResult = result as Error<LoginResponseModel>;
        expect(errorResult.exception, isA<ServerFailure>());
        verify(apiClientMock.login(requestBody)).called(1);
      },
    );

    test(
      "loginUser returns error when API call fails with generic Exception",
      () async {
        // Arrange
        when(
          apiClientMock.login(requestBody),
        ).thenThrow(Exception('Network error'));

        // Act
        final result = await dataSourceImpl.loginUser(
          body: requestBody,
          rememberMe: rememberMe,
        );

        // Assert
        expect(result, isA<Error<LoginResponseModel>>());
        final errorResult = result as Error<LoginResponseModel>;
        expect(errorResult.exception, isA<Exception>());
        verify(apiClientMock.login(requestBody)).called(1);
      },
    );

    test("loginUser handles server error (500) correctly", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/login'),
        response: Response(
          requestOptions: RequestOptions(path: '/login'),
          statusCode: 500,
          data: {'message': 'Internal server error'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(apiClientMock.login(requestBody)).thenThrow(dioException);

      // Act
      final result = await dataSourceImpl.loginUser(
        body: requestBody,
        rememberMe: rememberMe,
      );

      // Assert
      expect(result, isA<Error<LoginResponseModel>>());
      final errorResult = result as Error<LoginResponseModel>;
      expect(errorResult.exception, isA<ServerFailure>());
      verify(apiClientMock.login(requestBody)).called(1);
    });

    test("loginUser handles network timeout correctly", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/login'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout',
      );

      when(apiClientMock.login(requestBody)).thenThrow(dioException);

      // Act
      final result = await dataSourceImpl.loginUser(
        body: requestBody,
        rememberMe: rememberMe,
      );

      // Assert
      expect(result, isA<Error<LoginResponseModel>>());
      final errorResult = result as Error<LoginResponseModel>;
      expect(errorResult.exception, isA<ServerFailure>());
      verify(apiClientMock.login(requestBody)).called(1);
    });
  });
}
