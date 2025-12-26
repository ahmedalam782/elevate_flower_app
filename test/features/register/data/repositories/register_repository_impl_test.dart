import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/register/api/datasources/register_local_data_source_impl.dart';
import 'package:elevate_flower_app/features/register/api/datasources/register_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/register/data/models/register_request_body.dart';
import 'package:elevate_flower_app/features/register/data/models/register_user_model.dart';
import 'package:elevate_flower_app/features/register/data/models/register_user_response_dto.dart';
import 'package:elevate_flower_app/features/register/data/repositories/register_repository_impl.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_params.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_user_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_repository_impl_test.mocks.dart';

@GenerateMocks([RegisterLocalDataSourceImpl, RegisterRemoteDataSourceImpl])
void main() {
  late RegisterRepositoryImpl repository;
  late MockRegisterLocalDataSourceImpl mockLocalDataSource;
  late MockRegisterRemoteDataSourceImpl mockRemoteDataSource;

  setUp(() {
    mockLocalDataSource = MockRegisterLocalDataSourceImpl();
    mockRemoteDataSource = MockRegisterRemoteDataSourceImpl();
    repository = RegisterRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });
  group("test local data source implementation", () {
    test("saveAuthToken calls _localDataSource.saveAuthToken", () async {
      final token = "dummyToken";
      await repository.saveAuthToken(token);
      verify(mockLocalDataSource.saveAuthToken(token)).called(1);
    });
  });

  group("test remote data source implementation", () {
    final params = RegisterParams(
      firstName: "first",
      lastName: "last",
      email: "email",
      password: "password",
      passwordConfirmation: "confirmation password",
      phoneNumber: "01012345678",
      gender: "male",
    );
    test("registerUser transforms params into request body", () async {
      provideDummy<Result<RegisterUserResponseDto>>(
        Success<RegisterUserResponseDto>(),
      );
      when(
        mockRemoteDataSource.registerUser(any),
      ).thenAnswer((_) async => Success(data: null));

      await repository.registerUser(params: params);
      final captured = verify(
        mockRemoteDataSource.registerUser(captureAny),
      ).captured;
      final sentRequestBody = captured.first as RegisterRequestBody;

      expect(sentRequestBody.firstName, params.firstName);
      expect(sentRequestBody.lastName, params.lastName);
      expect(sentRequestBody.email, params.email);
      expect(sentRequestBody.password, params.password);
      expect(sentRequestBody.passwordConfirmation, params.passwordConfirmation);
      expect(sentRequestBody.phoneNumber, params.phoneNumber);
      expect(sentRequestBody.gender, params.gender);
    });

    test("test success case of registerUser", () async {
      final dummyResponse = RegisterUserResponseDto(
        message: "message",
        token: "token",
        user: User(
          id: "1",
          firstName: "first",
          lastName: "last",
          email: "email",
          phone: "01012345678",
          gender: "male",
        ),
      );
      provideDummy<Result<RegisterUserResponseDto>>(
        Success<RegisterUserResponseDto>(),
      );
      when(
        mockRemoteDataSource.registerUser(any),
      ).thenAnswer((_) async => Success(data: dummyResponse));
      final result = await repository.registerUser(params: params);

      expect(result, isA<Success<RegisterUserResponse>>());
      final successResult = result as Success<RegisterUserResponse>;
      expect(successResult.data?.message, dummyResponse.message);
      expect(successResult.data?.token, dummyResponse.token);
    });

    test("test error case of registerUser", () async{
      provideDummy<Result<RegisterUserResponseDto>>(
        Error<RegisterUserResponseDto>(),
      );
      final dummyException = Exception("dummy exception");
      when(
        mockRemoteDataSource.registerUser(any),
      ).thenAnswer((_) async => Error(exception: dummyException));
      final result = await repository.registerUser(params: params);
      expect(result, isA<Error<RegisterUserResponse>>());
      final errorResult = result as Error<RegisterUserResponse>;
      expect(errorResult.exception, isA<Exception>());
      expect(errorResult.exception, dummyException);
    });
  });
}
