import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/login/api/datasources/login_local_data_source_impl.dart';
import 'package:elevate_flower_app/features/login/api/datasources/login_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/login/data/models/login_request_model.dart';
import 'package:elevate_flower_app/features/login/data/models/login_response_model.dart';
import 'package:elevate_flower_app/features/login/data/models/login_user_dto.dart';
import 'package:elevate_flower_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:elevate_flower_app/features/login/domain/entities/login_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSourceImpl, LoginLocalDataSourceImpl])
void main() {
  late LoginRepositoryImpl repository;
  late MockLoginRemoteDataSourceImpl mockRemoteDataSource;
  late MockLoginLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockLoginRemoteDataSourceImpl();
    mockLocalDataSource = MockLoginLocalDataSourceImpl();
    repository = LoginRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group("test login repository implementation", () {
    const email = "test@example.com";
    const password = "password123";
    const rememberMe = true;

    group("test remote data source implementation", () {
      test("loginUser transforms params into request body", () async {
        provideDummy<Result<LoginResponseModel>>(
          const Success<LoginResponseModel>(),
        );

        when(
          mockRemoteDataSource.loginUser(
            body: anyNamed('body'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer((_) async => const Success(data: null));

        await repository.loginUser(
          email: email,
          password: password,
          rememberMe: rememberMe,
        );

        final captured = verify(
          mockRemoteDataSource.loginUser(
            body: captureAnyNamed('body'),
            rememberMe: captureAnyNamed('rememberMe'),
          ),
        ).captured;

        final sentRequestBody = captured[0] as LoginRequestModel;
        final sentRememberMe = captured[1] as bool;

        expect(sentRequestBody.email, email);
        expect(sentRequestBody.password, password);
        expect(sentRememberMe, rememberMe);
      });

      test("loginUser success case saves token and rememberMe", () async {
        // Arrange
        final dummyResponse = LoginResponseModel(
          message: "Login successful",
          token: "test_token_123",
          user: LoginUserDto(
            id: "user_123",
            firstName: "John",
            lastName: "Doe",
            email: email,
            gender: "male",
            phone: "123456",
            photo: "",
            role: "user",
            wishlist: [],
            addresses: [],
            createdAt: "2024-01-01",
          ),
        );

        provideDummy<Result<LoginResponseModel>>(
          const Success<LoginResponseModel>(),
        );

        when(
          mockRemoteDataSource.loginUser(
            body: anyNamed('body'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer((_) async => Success(data: dummyResponse));

        when(
          mockLocalDataSource.saveToken(any),
        ).thenAnswer((_) async => Future.value());

        when(
          mockLocalDataSource.saveRememberMe(any),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.loginUser(
          email: email,
          password: password,
          rememberMe: rememberMe,
        );

        // Assert
        expect(result, isA<Success<LoginResponseEntity>>());
        final successResult = result as Success<LoginResponseEntity>;
        expect(successResult.data?.message, dummyResponse.message);
        expect(successResult.data?.token, dummyResponse.token);
        expect(successResult.data?.user.email, email);

        verify(mockLocalDataSource.saveToken(dummyResponse.token)).called(1);
        verify(mockLocalDataSource.saveRememberMe(rememberMe)).called(1);
      });

      test("loginUser error case does not save data locally", () async {
        // Arrange
        provideDummy<Result<LoginResponseModel>>(
          const Error<LoginResponseModel>(),
        );

        final dummyException = Exception("Invalid credentials");

        when(
          mockRemoteDataSource.loginUser(
            body: anyNamed('body'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer((_) async => Error(exception: dummyException));

        // Act
        final result = await repository.loginUser(
          email: email,
          password: password,
          rememberMe: rememberMe,
        );

        // Assert
        expect(result, isA<Error<LoginResponseEntity>>());
        final errorResult = result as Error<LoginResponseEntity>;
        expect(errorResult.exception, isA<Exception>());
        expect(errorResult.exception, dummyException);

        verifyNever(mockLocalDataSource.saveToken(any));
        verifyNever(mockLocalDataSource.saveRememberMe(any));
      });

      test("loginUser handles null response", () async {
        // Arrange
        provideDummy<Result<LoginResponseModel>>(
          const Success<LoginResponseModel>(),
        );

        when(
          mockRemoteDataSource.loginUser(
            body: anyNamed('body'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer((_) async => const Success(data: null));

        // Act
        final result = await repository.loginUser(
          email: email,
          password: password,
          rememberMe: rememberMe,
        );

        // Assert
        expect(result, isA<Error<LoginResponseEntity>>());
        final errorResult = result as Error<LoginResponseEntity>;
        expect(errorResult.exception.toString(), contains('Response is null'));

        verifyNever(mockLocalDataSource.saveToken(any));
        verifyNever(mockLocalDataSource.saveRememberMe(any));
      });
    });
  });
}
